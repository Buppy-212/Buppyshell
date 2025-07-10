import Quickshell
import Quickshell.Hyprland
import "../services"
import "../widgets"

Block {
    id: block
    hovered: mouse.containsMouse
    StyledText {
        text: ""
        color: Theme.color.red
    }
    MouseBlock {
        id: mouse
        onClicked: mouse => {
            if (mouse.button == Qt.MiddleButton) {
                Quickshell.execDetached(["systemctl", "poweroff"]);
            } else {
                Hyprland.dispatch("global buppyshell:logout");
            }
        }
    }
}
