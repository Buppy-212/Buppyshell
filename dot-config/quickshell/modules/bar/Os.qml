import "root:/services"
import "root:/widgets"
import Quickshell
import Quickshell.Io
import QtQuick

BarBlock {
  BarText {
    text: ""
    font.pointSize: Theme.font.size.large
    color: Theme.color.blue
  }
  readonly property var process: Process {
    command: ["rofi", "-show", "drun", "-config", "~/.config/rofi/menu.rasi"]
  }
  function onClicked(): void {
    process.startDetached();
  }
}
