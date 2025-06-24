import Quickshell.Services.UPower
import QtQuick
import Quickshell
import Quickshell.Io
import "root:/services"
import "root:/widgets"

BarBlock {
  BarText {
    text: Math.round(UPower.displayDevice.percentage*100)
    color: Theme.color.green
  }
    readonly property var process: Process {
      command: ["uwsm", "app", "--", "btop.desktop"]
    }
    function onClicked(): void {
      process.startDetached();
    }
}
