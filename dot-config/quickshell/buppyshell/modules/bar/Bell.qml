import Quickshell.Services.Notifications
import qs.services
import qs.widgets

StyledButton {
    NotificationServer {
        id: notificationServer
    }
    text: notificationServer.trackedNotifications.values.length ? "󱅫" : GlobalState.doNotDisturb ? "󰂠" : "󰂚"
    font.pixelSize: height - Theme.margin.small
    function tapped(eventPoint, button): void {
        if (GlobalState.sidebarModule === GlobalState.SidebarModule.Notifications || !GlobalState.sidebar) {
            GlobalState.sidebar = !GlobalState.sidebar;
            GlobalState.player = false;
        }
        GlobalState.sidebarModule = GlobalState.SidebarModule.Notifications;
    }
}
