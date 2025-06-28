pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property bool active
  Process {
    command: ["pidof", "hypridle"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: if (text) {
        root.active = true;
      } else {
        root.active = false;
      }
    }
  }
  SocketServer {
    active: true
    path: "/tmp/inhibitor.sock"
    handler: Socket {
      parser: SplitParser {
        onRead: message => {root.active = message; connected = false}
      }
    }
  }
}
