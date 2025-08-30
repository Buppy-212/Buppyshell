import Quickshell.Bluetooth
import qs.widgets
import qs.services

StyledButton {
    text: Bluetooth.defaultAdapter?.enabled ?? Bluetooth.adapters.values[0]?.enabled ? "󰂯" : "󰂲"
    color: Theme.color.blue
    font.pixelSize: Theme.font.size.medium
    function tapped(): void {
        if (GlobalState.sidebarModule === GlobalState.SidebarModule.Bluetooth || !GlobalState.sidebar) {
            GlobalState.sidebar = !GlobalState.sidebar;
        }
        GlobalState.sidebarModule = GlobalState.SidebarModule.Bluetooth;
    }
}
