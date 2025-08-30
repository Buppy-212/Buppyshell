import qs.widgets
import qs.services

StyledButton {
    text: "󰤨"
    color: Theme.color.green
    font.pixelSize: Theme.font.size.medium
    function tapped(): void {
        if (GlobalState.sidebarModule === GlobalState.SidebarModule.Network || !GlobalState.sidebar) {
            GlobalState.sidebar = !GlobalState.sidebar;
        }
        GlobalState.sidebarModule = GlobalState.SidebarModule.Network;
    }
}
