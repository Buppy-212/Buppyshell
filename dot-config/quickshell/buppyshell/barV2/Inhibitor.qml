import "../services"
import "../widgets"

Block {
    hovered: mouse.containsMouse
    StyledText {
        text: Idle.active ? "" : ""
        color: Theme.color.cyan
    }
    MouseBlock {
        id: mouse
        onClicked: Idle.toggleInhibitor()
    }
}
