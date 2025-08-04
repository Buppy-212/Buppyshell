import Quickshell.Bluetooth
import qs.widgets
import qs.services

Block {
    hovered: mouse.containsMouse
    StyledText {
        text: Bluetooth.defaultAdapter?.enabled ?? Bluetooth.adapters.values[0]?.enabled ? "󰂯" : "󰂲"
        anchors.fill: parent
        color: Theme.color.blue
        font.pixelSize: height - Theme.margin.small
    }
    MouseBlock {
        id: mouse
        onClicked: {
            if (GlobalState.sidebarModule == GlobalState.SidebarModule.Bluetooth || !GlobalState.sidebar) {
                GlobalState.sidebar = !GlobalState.sidebar;
                GlobalState.player = false;
            }
            GlobalState.sidebarModule = GlobalState.SidebarModule.Bluetooth;
        }
    }
}
