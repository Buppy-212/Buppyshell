import Quickshell
import Quickshell.Io
import "root:/services"
import "."

Block {
  id: block
  readonly property var process: Process {
    command: ["systemctl", "poweroff"]
  }
  SymbolText {
    text: "power_settings_new"
    color: Theme.color.red
  }
  MouseBlock {
    id: mouse
    onClicked: {
      process.startDetached();
      Qt.quit();
    }
  }
}
