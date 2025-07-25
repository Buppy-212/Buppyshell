import Quickshell.Bluetooth
import qs.widgets
import qs.services

Block {
    hovered: mouse.containsMouse
    SymbolText {
        text: Bluetooth.defaultAdapter?.enabled ?? Bluetooth.adapters.values[0]?.enabled ? "bluetooth" : "bluetooth_disabled"
        color: Theme.color.blue
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
