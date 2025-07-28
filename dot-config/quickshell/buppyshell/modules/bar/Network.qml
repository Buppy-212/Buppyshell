import qs.widgets
import qs.services

Block {
    hovered: mouse.containsMouse
    StyledText {
        text: "󰤨"
        color: Theme.color.green
        font.pixelSize: height - Theme.margin.small
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
