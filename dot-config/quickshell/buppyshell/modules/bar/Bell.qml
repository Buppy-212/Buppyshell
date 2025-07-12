import Quickshell.Hyprland
import "../notifications"
import "../../services"
import "../../widgets"

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
