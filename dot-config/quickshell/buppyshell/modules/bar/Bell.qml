import Quickshell.Hyprland
import Quickshell.Services.Notifications
import qs.services
import qs.widgets

StyledButton {
    NotificationServer {
        id: notificationServer
    }
    text: notificationServer.trackedNotifications.values.length ? "󱅫" : "󰂚"
    font.pixelSize: height - Theme.margin.small
    function tapped(pointEvent, button): void {
        if (button == Qt.MiddleButton) {
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
