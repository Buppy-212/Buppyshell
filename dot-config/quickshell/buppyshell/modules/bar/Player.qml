import qs.services
import qs.widgets

StyledButton {
    text: "󰐎"
    font.pixelSize: height - Theme.margin.small
    function tapped(eventPoint, button): void {
        switch (button) {
        case Qt.LeftButton:
            GlobalState.sidebar = true;
            GlobalState.player = !GlobalState.player;
            break;
        default:
            GlobalState.player = !GlobalState.sidebar;
            GlobalState.sidebar = !GlobalState.sidebar;
        }
    }
}
