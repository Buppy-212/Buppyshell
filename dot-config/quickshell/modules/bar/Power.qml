import "root:/services"
import "root:/widgets"
import Quickshell
import Quickshell.Io
import QtQuick

BarBlock {
  BarText {
    text: "power_settings_new"
    color: Theme.color.red
    font.pointSize: Theme.font.size.large
    font.family: Theme.font.family.material
  }
    readonly property var process: Process {
      command: ["systemctl", "poweroff"]
    }
    function onClicked(): void {
      process.startDetached();
      Qt.quit();
    }
}
