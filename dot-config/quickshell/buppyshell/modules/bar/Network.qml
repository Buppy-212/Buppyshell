import qs.widgets
import qs.services

Block {
    hovered: mouse.containsMouse
    SymbolText {
        text: "signal_wifi_4_bar"
        color: Theme.color.green
    }
    MouseBlock {
        id: mouse
        onClicked: {
            if (GlobalState.sidebarModule == GlobalState.SidebarModule.Network || !GlobalState.sidebar) {
                GlobalState.sidebar = !GlobalState.sidebar;
                GlobalState.player = false;
            }
            GlobalState.sidebarModule = GlobalState.SidebarModule.Network;
        }
    }
}
