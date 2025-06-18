pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property string updates
  Process {
    id: updateProc
    command: ["cat", "/home/will/.local/state/updates"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.updates = this.text
    }
  }
  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: updateProc.running = true
  }
}
