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
  MouseArea {
    id: mouse
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    onClicked: {
      process.startDetached();
      Qt.quit();
    }
  }
}
