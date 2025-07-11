import Quickshell.Hyprland
import Quickshell.Bluetooth
import QtQuick
import "../notifications"
import "../services"

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
                    GlobalState.bluetooth = false;
                    GlobalState.player = false;
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
                GlobalState.bluetooth = true;
                GlobalState.player = false;
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
                GlobalState.bluetooth = false;
                GlobalState.player = true;
            }
        }
    }
}
