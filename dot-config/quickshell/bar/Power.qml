import Quickshell
import "../services"

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
                Hyprland.dispatch("exec systemctl poweroff");
            } else {
                Hyprland.dispatch("global buppyshell:logout");
            }
        }
    }
}
