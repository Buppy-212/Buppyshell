import Quickshell.Services.Pipewire
import Quickshell
import QtQuick
import "root:/services"
import "root:/widgets"

Rectangle {
  implicitHeight: 24
  implicitWidth: 30
  color: "transparent"
  property PwNode defaultSink: Pipewire.defaultAudioSink
  PwObjectTracker {
    objects: [defaultSink]
  }
  BarText {
    text: defaultSink?.audio.muted ? "" : defaultSink?.audio.volume === 1 ? "" : Math.round(defaultSink?.audio.volume * 100)
    color: Theme.color.blue
  }
  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    onClicked: defaultSink.audio.muted = !defaultSink.audio.muted;
    onWheel: (wheel) => {
      if (wheel.angleDelta.y > 0) {
        defaultSink.audio.volume += 0.05
      } else {
        defaultSink.audio.volume -= 0.05
      }
    }
  }
}
