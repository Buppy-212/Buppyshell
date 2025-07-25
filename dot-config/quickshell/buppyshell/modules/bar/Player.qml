import qs.services
import qs.widgets

Block {
    hovered: playerMouse.containsMouse
    SymbolText {
        text: "play_pause"
    }
    MouseBlock {
        id: playerMouse
        onClicked: mouse => {
          if (mouse.button == Qt.LeftButton) {
            GlobalState.sidebar = true;
            GlobalState.player = !GlobalState.player; 
          } else {
            GlobalState.sidebar = ! GlobalState.sidebar
            GlobalState.player = GlobalState.sidebar
          }
        }
    }
}
