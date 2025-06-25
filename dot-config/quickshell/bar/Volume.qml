import Quickshell.Services.Pipewire
import Quickshell
import Quickshell.Io
import QtQuick
import "root:/services"
import "root:/widgets"

Rectangle {
  implicitHeight: 24
  implicitWidth: 30
  color: mouse.containsMouse ? Theme.color.gray : "transparent"
  radius: Theme.rounding
  property PwNode defaultSink: Pipewire.defaultAudioSink
  readonly property var process: Process {
    command: ["floatty", "pulsemixer"]
  }
  PwObjectTracker {
    objects: [defaultSink]
  }
  BarText {
    text: defaultSink?.audio.muted ? "" : defaultSink?.audio.volume === 1 ? "" : Math.round(defaultSink?.audio.volume * 100)
    color: Theme.color.blue
  }
  MouseArea {
    id: mouse
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    onClicked: (mouse) => {
      if (mouse.button == Qt.RightButton) {
        defaultSink.audio.muted = !defaultSink.audio.muted;
      } else {
        process.startDetached()
      }
    }
    onWheel: (wheel) => {
      if (wheel.angleDelta.y > 0) {
        defaultSink.audio.volume += 0.05;
      } else {
        defaultSink.audio.volume -= 0.05;
      }
    }
  }
}
