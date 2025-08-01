import Quickshell.Hyprland
import Quickshell.Services.Notifications
import qs.services
import qs.widgets

Block {
    hovered: mouse.containsMouse
    NotificationServer {
        id: notificationServer
    }
    StyledText {
        text: notificationServer.trackedNotifications.values.length ? "󱅫" : "󰂚"
        font.pixelSize: height - Theme.margin.small
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
