import Quickshell.Hyprland
import "../notifications"

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
                Hyprland.dispatch("global buppyshell:sidebar");
            }
        }
    }
}
