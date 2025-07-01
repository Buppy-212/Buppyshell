import Quickshell.Services.UPower
import Quickshell
import Quickshell.Io
import "root:/services"

Block {
  readonly property var process: Process {
    command: ["uwsm", "app", "--", "btop.desktop"]
  }
  StyledText {
    text: Math.round(UPower.displayDevice.percentage*100)
    color: Theme.color.green
  }
  MouseBlock {
    id: mouse
    onClicked: process.startDetached();
  }
}
