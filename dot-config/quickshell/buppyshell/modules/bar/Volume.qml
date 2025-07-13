import Quickshell.Services.Pipewire
import "../../services"
import "../../widgets"

Block {
    id: volumeWidget
    hovered: mouse.containsMouse
    readonly property int volume: Pipewire.defaultAudioSink?.audio.volume * 100
    readonly property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? false
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }
    StyledText {
        text: volumeWidget.muted || volumeWidget.volume == 0 ? "" : volumeWidget.volume == 100 ? "" : volumeWidget.volume
        color: Theme.color.blue
    }
    MouseBlock {
        id: mouse
        onClicked: mouse => {
            if (mouse.button == Qt.MiddleButton) {
                Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted;
            } else {
                if (GlobalState.sidebarModule == GlobalState.SidebarModule.Volume || !GlobalState.sidebar) {
                    GlobalState.sidebar = !GlobalState.sidebar;
                    GlobalState.player = false;
                }
                GlobalState.sidebarModule = GlobalState.SidebarModule.Volume;
            }
        }
        onWheel: wheel => {
            if (wheel.angleDelta.y > 0) {
                if (volumeWidget.volume <= 95) {
                    Pipewire.defaultAudioSink.audio.volume += 0.05;
                } else {
                    Pipewire.defaultAudioSink.audio.volume = 1;
                }
            } else {
                Pipewire.defaultAudioSink.audio.volume -= 0.05;
            }
        }
    }
}
