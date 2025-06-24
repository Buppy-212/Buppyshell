pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property int brightness
  Process {
    id: updateProc
    command: ["brightnessctl", "g"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.brightness = text/2.55
    }
  }
  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: updateProc.running = true;
  }
  function update(): void {
    updateProc.running = true;
  }
}
