import qs.services
import qs.widgets

StyledButton {
    text: "󰐎"
    font.pixelSize: height - Theme.margin.small
    function tapped(pointEvent, button) {
        if (button == Qt.LeftButton) {
            GlobalState.sidebar = true;
            GlobalState.player = !GlobalState.player;
        } else {
            GlobalState.sidebar = !GlobalState.sidebar;
            GlobalState.player = GlobalState.sidebar;
        }
    }
}
