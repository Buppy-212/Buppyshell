import Quickshell.Bluetooth
import "../../widgets"
import "../../services"

Block {
    hovered: mouse.containsMouse
    SymbolText {
        text: Bluetooth.defaultAdapter?.enabled ?? Bluetooth.adapters.values[0]?.enabled ? "bluetooth" : "bluetooth_disabled"
        color: Theme.color.blue
    }
    MouseBlock {
        id: mouse
        onClicked: {
            GlobalState.sidebar = !GlobalState.sidebar;
            GlobalState.player = false;
            GlobalState.sidebarModule = GlobalState.SidebarModule.Bluetooth;
        }
    }
}
