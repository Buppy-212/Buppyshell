import Quickshell.Hyprland
import Quickshell.Bluetooth
import Quickshell.Services.Pipewire
import QtQuick
import "../notifications"
import "../../services"
import "../../widgets"

Column {
    spacing: 2
    Block {
        hovered: mouse.containsMouse
        Server {
            id: server
        }
        SymbolText {
            text: server.trackedNotifications.values.length ? "notifications_unread" : "notifications"
        }
        MouseBlock {
            id: mouse
            onClicked: mouse => {
                if (mouse.button == Qt.MiddleButton) {
                    Hyprland.dispatch("global buppyshell:clearNotifs");
                } else {
                    GlobalState.sidebar = !GlobalState.sidebar;
                    GlobalState.sidebarModule = GlobalState.SidebarModule.Notifications;
                    GlobalState.player = false;
                }
            }
        }
    }
    Block {
        id: volumeWidget
        hovered: volumeMouse.containsMouse
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
            id: volumeMouse
            onClicked: mouse => {
                if (mouse.button == Qt.MiddleButton) {
                    Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted;
                } else {
                    GlobalState.sidebar = !GlobalState.sidebar;
                    GlobalState.sidebarModule = GlobalState.SidebarModule.Volume;
                    GlobalState.player = false;
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
    Block {
        hovered: bluetoothMouse.containsMouse
        SymbolText {
            text: Bluetooth.defaultAdapter?.enabled ?? Bluetooth.adapters.values[0]?.enabled ? "bluetooth" : "bluetooth_disabled"
            color: Theme.color.blue
        }
        MouseBlock {
            id: bluetoothMouse
            onClicked: {
                GlobalState.sidebar = !GlobalState.sidebar;
                GlobalState.player = false;
                GlobalState.sidebarModule = GlobalState.SidebarModule.Bluetooth
            }
        }
    }
    Block {
        hovered: playerMouse.containsMouse
        SymbolText {
            text: "play_pause"
        }
        MouseBlock {
            id: playerMouse
            onClicked: {
                GlobalState.sidebar = !GlobalState.sidebar;
                GlobalState.player = true;
            }
        }
    }
}
