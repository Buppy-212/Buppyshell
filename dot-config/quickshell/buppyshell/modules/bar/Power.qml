import Quickshell
import qs.services
import qs.widgets

Block {
    id: block
    hovered: mouse.containsMouse
    SymbolText {
        text: "power_settings_new"
        color: Theme.color.red
    }
    MouseBlock {
        id: mouse
        onClicked: mouse => {
            if (mouse.button == Qt.MiddleButton) {
                Quickshell.execDetached(["systemctl", "poweroff"]);
            } else {
                GlobalState.overlay = !GlobalState.overlay;
                GlobalState.launcherModule = GlobalState.LauncherModule.Logout;
            }
        }
    }
}
