import Quickshell.Services.UPower
import QtQuick
import Quickshell
import Quickshell.Io
import "root:/services"
import "."

Block {
  readonly property var process: Process {
    command: ["uwsm", "app", "--", "btop.desktop"]
  }
  StyledText {
    text: Math.round(UPower.displayDevice.percentage*100)
    color: Theme.color.green
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
