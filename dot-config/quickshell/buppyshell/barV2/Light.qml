import "../services"
import "../widgets"

Block {
    hovered: mouse.containsMouse
    StyledText {
        text: mouse.containsMouse ? Brightness.brightness : Brightness.nightlight ? "" : ""
        color: Theme.color.yellow
        font.family: Theme.font.family.mono
        font.pointSize: Theme.font.size.normal
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
