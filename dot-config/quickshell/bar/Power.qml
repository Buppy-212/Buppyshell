import Quickshell
import "root:/services"

Block {
  id: block
  SymbolText {
    text: "power_settings_new"
    color: Theme.color.red
  }
  MouseBlock {
    id: mouse
    onClicked: (mouse) => {
      if (mouse.button == Qt.MiddleButton) {
        Hyprland.dispatch("exec systemctl poweroff")
        Qt.quit()
      } else {
        Hyprland.dispatch("global buppyshell:logout");
      }
    }
  }
}
