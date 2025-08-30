import Quickshell
import qs.services
import qs.services.updates
import qs.widgets

StyledButton {
    function tapped(eventPoint, button): void {
        switch (button) {
        case Qt.LeftButton:
            Quickshell.execDetached(["floatty", "update", "tmux"]);
            break;
        default:
            if (GlobalState.sidebarModule === GlobalState.SidebarModule.updates || !GlobalState.sidebar) {
                GlobalState.sidebar = !GlobalState.sidebar;
            }
            GlobalState.sidebarModule = GlobalState.SidebarModule.updates;
        }
    }

    visible: Updates.updates.length === 0 ? false : true
    text: hovered ? Updates.updates.length : ``
}
