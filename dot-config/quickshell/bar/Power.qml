import Quickshell
import Quickshell.Io
import QtQuick
import "root:/services"
import "."

Block {
  id: block
  readonly property var process: Process {
    command: ["systemctl", "poweroff"]
  }
  Text {
    text: "power_settings_new"
    color: Theme.color.red
    font.family: Theme.font.family.material
    font.pointSize: Theme.font.size.large
    font.bold: true
    anchors.centerIn: parent
  }
  MouseBlock {
    id: mouse
    onClicked: {
      process.startDetached();
      Qt.quit();
    }
  }
}
