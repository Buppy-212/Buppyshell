import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import "root:/services"

Block {
  readonly property int volume: Pipewire.defaultAudioSink?.audio.volume * 100
  readonly property bool muted: Pipewire.defaultAudioSink?.audio.muted
  readonly property var process: Process {
    command: ["uwsm", "app", "--", "pavucontrol-qt"]
  }
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
  }
  StyledText {
    text: muted || volume == 0 ? "" : volume == 1 ? "" : volume
    color: Theme.color.blue
  }
  MouseBlock {
    id: mouse
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
