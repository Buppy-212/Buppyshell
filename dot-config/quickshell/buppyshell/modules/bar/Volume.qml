import Quickshell.Services.Pipewire
import qs.services
import qs.widgets

StyledButton {
    id: root
    readonly property int volume: Pipewire.defaultAudioSink?.audio.volume * 100
    readonly property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? false
    text: root.muted || root.volume === 0 ? "" : root.volume === 100 ? "" : root.volume
    color: Theme.color.blue
    scrollable: true
    function tapped(eventPoint, button): void {
        switch (button) {
        case Qt.MiddleButton:
            Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted;
            break;
        default:
            if (GlobalState.sidebarModule === GlobalState.SidebarModule.Volume || !GlobalState.sidebar) {
                GlobalState.sidebar = !GlobalState.sidebar;
                GlobalState.player = false;
            }
            GlobalState.sidebarModule = GlobalState.SidebarModule.Volume;
        }
    }
    function scrolled(event): void {
        if (event.angleDelta.y > 0) {
            if (root.volume <= 95) {
                Pipewire.defaultAudioSink.audio.volume += 0.05;
            } else {
                Pipewire.defaultAudioSink.audio.volume = 1;
            }
        } else {
            Pipewire.defaultAudioSink.audio.volume -= 0.05;
        }
    }
}
