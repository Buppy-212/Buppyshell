import Quickshell
import Quickshell.Services.UPower
import qs.services
import qs.widgets

StyledButton {
    text: Math.round(UPower.displayDevice.percentage * 100)
    color: Theme.color.green
    function tapped(): void {
        Quickshell.execDetached(["uwsm", "app", "--", "btop.desktop"]);
    }
}
