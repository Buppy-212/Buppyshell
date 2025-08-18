import qs.services
import qs.widgets

StyledButton {
    text: hovered ? Math.round(Brightness.brightness * 100) : Brightness.nightlight ? "" : ""
    font.pixelSize: hovered ? Theme.font.size.normal : Theme.font.size.medium
    color: Theme.color.yellow
    scrollable: true
    function tapped(eventPoint, button): void {
        switch (button) {
        case Qt.LeftButton:
            Brightness.toggleNightlight();
            break;
        default:
            Brightness.monitor();
        }
    }
    function scrolled(event): void {
        if (event.angleDelta.y > 0) {
            Brightness.inc();
        } else {
            Brightness.dec();
        }
    }
}
