import Quickshell
import qs.services
import qs.widgets

StyledButton {
    visible: Updates.updates == 0 ? false : true
    text: hovered ? `${Updates.updates}\n` : ``
    function tapped() {
        Quickshell.execDetached(["floatty", "update"]);
    }
}
