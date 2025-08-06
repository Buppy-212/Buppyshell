import Quickshell
import qs.services
import qs.widgets

StyledButton {
    text: "⏻"
    color: Theme.color.red
    font.pixelSize: Theme.font.size.large
    function tapped(button) {
        if (button == Qt.MiddleButton) {
            Quickshell.execDetached(["systemctl", "poweroff"]);
        } else {
            GlobalState.launcherModule == GlobalState.LauncherModule.Logout ? GlobalState.launcher = !GlobalState.launcher : GlobalState.launcher = true;
            GlobalState.launcherModule = GlobalState.LauncherModule.Logout;
        }
    }
}
