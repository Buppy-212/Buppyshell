import Quickshell.Hyprland
import "../notifications"
import "../services"
import "../widgets"

Block {
    hovered: mouse.containsMouse
    Server {
        id: server
    }
    StyledText {
        text: server.trackedNotifications.values.length ? "󱅫" : "󰂚"
    }
    MouseBlock {
        id: mouse
        onClicked: mouse => {
            if (mouse.button == Qt.MiddleButton) {
                Hyprland.dispatch("global buppyshell:clearNotifs");
            } else {
                GlobalState.sidebar = !GlobalState.sidebar;
            }
        }
    }
}
