import qs.services
import qs.widgets

Block {
    hovered: mouse.containsMouse
    SymbolText {
        text: Idle.active ? "visibility_off" : "visibility"
        color: Theme.color.cyan
    }
    MouseBlock {
        id: mouse
        onClicked: Idle.toggleInhibitor()
    }
}
