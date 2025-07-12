import "../../services"
import "../../widgets"

Block {
    hovered: playerMouse.containsMouse
    SymbolText {
        text: "play_pause"
    }
    MouseBlock {
        id: playerMouse
        onClicked: {
            GlobalState.sidebar = !GlobalState.sidebar;
            GlobalState.player = true;
        }
    }
}
