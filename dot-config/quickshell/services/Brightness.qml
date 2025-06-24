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
  function update(): void {
    updateProc.running = true;
  }
}
