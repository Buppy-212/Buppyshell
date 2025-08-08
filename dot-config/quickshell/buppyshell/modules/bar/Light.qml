import qs.services
import qs.widgets

StyledButton {
    text: hovered ? Math.round(Brightness.brightness * 100) : Brightness.nightlight ? "" : ""
    font.pixelSize: hovered ? Theme.font.size.normal : Theme.font.size.large
    color: Theme.color.yellow
    function tapped(eventPoint, button): void {
        if (button == Qt.LeftButton) {
            Brightness.toggleNightlight();
        } else {
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
