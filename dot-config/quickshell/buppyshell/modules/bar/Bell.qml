import Quickshell.Hyprland
import Quickshell.Services.Notifications
import qs.services
import qs.widgets

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
                if (GlobalState.sidebarModule == GlobalState.SidebarModule.Notifications || !GlobalState.sidebar) {
                    GlobalState.sidebar = !GlobalState.sidebar;
                    GlobalState.player = false;
                }
                GlobalState.sidebarModule = GlobalState.SidebarModule.Notifications;
            }
        }
    }
}
