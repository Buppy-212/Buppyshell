import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import "root:/services"

Block {
  readonly property int volume: Pipewire.defaultAudioSink?.audio.volume * 100
  readonly property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? false
  readonly property var process: Process {
    command: ["uwsm", "app", "--", "pavucontrol-qt"]
  }
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
  }
  StyledText {
    text: muted || volume == 0 ? "" : volume == 100 ? "" : volume
    color: Theme.color.blue
  }
  MouseBlock {
    id: mouse
    onClicked: (mouse) => {
      if (mouse.button == Qt.RightButton) {
        Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted;
      } else {
        process.startDetached()
      }
    }
    onWheel: (wheel) => {
      if (wheel.angleDelta.y > 0) {
        if (volume <= 95) {
          Pipewire.defaultAudioSink.audio.volume += 0.05
        } else {
          Pipewire.defaultAudioSink.audio.volume = 1
        }
      } else {
        Pipewire.defaultAudioSink.audio.volume -= 0.05;
      }
    }
  }
}
