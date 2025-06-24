pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property int brightness
  property bool nightlight
  Process {
    id: brightnessProc
    command: ["brightnessctl", "g"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.brightness = text/2.55
    }
  }
  Process {
    id: nightlightProc
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
  function update(): void {
    brightnessProc.running = true;
  }
}
