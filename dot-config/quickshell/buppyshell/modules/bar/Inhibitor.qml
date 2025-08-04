import qs.services
import qs.widgets

Block {
    hovered: mouse.containsMouse
    StyledText {
        text: Idle.active ? "" : ""
        anchors.fill: parent
        color: Theme.color.cyan
    }
    MouseBlock {
        id: mouse
        onClicked: Idle.toggleInhibitor()
    }
}
