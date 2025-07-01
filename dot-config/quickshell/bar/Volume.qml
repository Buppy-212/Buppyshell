import Quickshell.Services.Pipewire
import Quickshell
import Quickshell.Io
import "root:/services"
import "."

Block {
  property PwNode defaultSink: Pipewire.defaultAudioSink
  property PwNode defaultSource: Pipewire.defaultAudioSource
  readonly property var process: Process {
    command: ["pavucontrol-qt"]
  }
  PwObjectTracker {
    objects: [defaultSink, defaultSource]
  }
  StyledText {
    text: defaultSink?.audio.muted || defaultSink?.audio.volume == 0 ? "" : defaultSink?.audio.volume == 1 ? "" : Math.round(defaultSink?.audio.volume * 100)
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
