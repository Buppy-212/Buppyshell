import qs.services
import qs.widgets

StyledButton {
    text: Idle.active ? "" : ""
    color: Theme.color.cyan
    function tapped(): void {
        Idle.toggleInhibitor();
    }
}
