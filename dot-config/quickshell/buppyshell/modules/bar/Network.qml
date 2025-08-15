import qs.widgets
import qs.services

StyledButton {
    text: "󰤨"
    color: Theme.color.green
    font.pixelSize: height - Theme.margin.small
    function tapped(): void {
        if (GlobalState.sidebarModule === GlobalState.SidebarModule.Network || !GlobalState.sidebar) {
            GlobalState.sidebar = !GlobalState.sidebar;
            GlobalState.player = false;
        }
        GlobalState.sidebarModule = GlobalState.SidebarModule.Network;
    }
}
