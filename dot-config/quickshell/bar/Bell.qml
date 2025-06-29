import Quickshell
import "root:/services"
import "."

Block {
  SymbolText{
    text: "notifications"
  }
  MouseBlock {
    id: mouse
    onClicked: (mouse) => {
      if (mouse.button == Qt.MiddleButton) {
        Hyprland.dispatch("global buppyshell:clearNotifs");
      } else {
        Hyprland.dispatch("global buppyshell:toggleSidebar");
      }
    }
  }
}
