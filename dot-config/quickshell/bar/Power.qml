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
    onClicked: Hyprland.dispatch("exec uwsm app -- rofi-wrapper power menu");
  }
}
