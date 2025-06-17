import "root:/services"
import "root:/widgets"
import Quickshell
import Quickshell.Io
import QtQuick

BarBlock {
  visible: Updates.updates == 0 ? false : true
  BarText{
    text: ""
  }
  readonly property var process: Process {
    command: ["kitty", "-e", "update"]
  }
  function onClicked(): void {
    process.startDetached();
  }
}
