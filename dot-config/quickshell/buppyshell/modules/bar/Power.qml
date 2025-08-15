import Quickshell
import qs.services
import qs.widgets

StyledButton {
    text: "⏻"
    color: Theme.color.red
    font.pixelSize: Theme.font.size.large
    function tapped(button): void {
        switch (button) {
        case Qt.MiddleButton:
            Quickshell.execDetached(["systemctl", "poweroff"]);
            break;
        default:
            GlobalState.launcherModule = GlobalState.LauncherModule.Logout;
            GlobalState.launcher = true;
        }
    }
}
