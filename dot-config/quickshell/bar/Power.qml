import "root:/services"
import "root:/widgets"
import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
  id: block
  implicitWidth: 30
  implicitHeight: 24
  color: mouse.containsMouse ? Theme.color.gray : "transparent"
  radius: Theme.rounding
  readonly property var process: Process {
    command: ["systemctl", "poweroff"]
  }
  BarText {
    text: "power_settings_new"
    color: Theme.color.red
    font.pointSize: Theme.font.size.large
    font.family: Theme.font.family.material
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
