import Quickshell
import Quickshell.Io
import "root:/services"

Block {
  id: block
  readonly property var process: Process {
    command: ["rofi-wrapper", "power", "menu"]
  }
  SymbolText {
    text: "power_settings_new"
    color: Theme.color.red
  }
  MouseBlock {
    id: mouse
    onClicked: {
      process.startDetached();
    }
  }
}
