pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property int brightness
  property bool nightlight
  Process {
    command: ["brightnessctl", "g"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.brightness = text/2.55
    }
  }
  Process {
    command: ["pidof", "hyprsunset"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: if (text) {
        root.nightlight = true;
      } else {
        root.nightlight = false;
      }
    }
  }
  SocketServer {
    active: true
    path: "/tmp/brightness.sock"
    handler: Socket {
      parser: SplitParser {
        onRead: message => {root.brightness = message / 2.55; connected = false}
      }
    }
  }
  SocketServer {
    active: true
    path: "/tmp/nightlight.sock"
    handler: Socket {
      parser: SplitParser {
        onRead: message => {root.nightlight = message; connected = false}
      }
    }
  }
}
