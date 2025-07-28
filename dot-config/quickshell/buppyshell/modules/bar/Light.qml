import qs.services
import qs.widgets

Block {
    hovered: mouse.containsMouse
    StyledText {
        text: mouse.containsMouse ? Brightness.brightness : Brightness.nightlight ? "" : ""
        color: Theme.color.yellow
        font.pixelSize: mouse.containsMouse ? Theme.font.size.normal : Theme.font.size.large
    }
    MouseBlock {
        id: mouse
        onClicked: mouse => {
            if (mouse.button == Qt.LeftButton) {
                Brightness.toggleNightlight();
            } else {
                Brightness.monitor();
            }
        }
        onWheel: wheel => {
            if (wheel.angleDelta.y > 0) {
                Brightness.inc();
            } else {
                Brightness.dec();
            }
        }
    }
}
