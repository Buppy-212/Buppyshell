import Quickshell.Services.UPower
import QtQuick
import Quickshell
import Quickshell.Io
import "root:/services"

Rectangle {
  readonly property var process: Process {
    command: ["uwsm", "app", "--", "btop.desktop"]
  }
  implicitHeight: Theme.blockHeight
  implicitWidth: Theme.blockWidth
  color: mouse.containsMouse ? Theme.color.gray : "transparent"
  radius: Theme.rounding
  Text {
    text: Math.round(UPower.displayDevice.percentage*100)
    color: Theme.color.green
    font.family: Theme.font.family.mono
    font.pointSize: Theme.font.size.normal
    font.bold: true
    anchors.centerIn: parent
  }
    MouseArea {
      id: mouse
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton| Qt.RightButton
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true
      onClicked: process.startDetached();
    }
}
