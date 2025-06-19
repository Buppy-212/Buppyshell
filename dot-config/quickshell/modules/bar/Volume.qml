import Quickshell.Services.Pipewire
import Quickshell
import QtQuick
import "root:/services"
import "root:/widgets"

BarBlock {
  property var defaultSink: Pipewire.defaultAudioSink
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }
  BarText {
    text: defaultSink.audio.muted ? "" : defaultSink.audio.volume === 1 ? "" : Math.round(defaultSink.audio.volume * 100)
    color: Theme.color.blue
  }
  function onClicked(): void {
    defaultSink.audio.muted = !defaultSink.audio.muted
  }
}
