import Quickshell.Hyprland
import Quickshell.Services.Notifications
import "../../services"
import "../../widgets"

Block {
    hovered: mouse.containsMouse
    NotificationServer {
        id: notificationServer
    }
    SymbolText {
        text: notificationServer.trackedNotifications.values.length ? "notifications_unread" : "notifications"
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
