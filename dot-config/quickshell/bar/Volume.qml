import Quickshell.Services.Pipewire
import Quickshell
import Quickshell.Io
import QtQuick
import "root:/services"

Rectangle {
  implicitHeight: Theme.blockHeight
  implicitWidth: Theme.blockWidth
  color: mouse.containsMouse ? Theme.color.gray : "transparent"
  radius: Theme.rounding
  property PwNode defaultSink: Pipewire.defaultAudioSink
  readonly property var process: Process {
    command: ["floatty", "pulsemixer"]
  }
  PwObjectTracker {
    objects: [defaultSink]
  }
  Text {
    text: defaultSink?.audio.muted ? "" : defaultSink?.audio.volume === 1 ? "" : Math.round(defaultSink?.audio.volume * 100)
    color: Theme.color.blue
    font.family: Theme.font.family.mono
    font.pointSize: Theme.font.size.normal
    font.bold: true
    anchors.centerIn: parent
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
