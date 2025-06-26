import Quickshell
import QtQuick
import "root:/services"
import "."

Item {
  implicitWidth: block.width
  implicitHeight: block.height
  Rectangle {
    id: block
    implicitWidth: Theme.blockWidth
    implicitHeight: Theme.blockHeight
    color: mouse.containsMouse ? Theme.color.gray : "transparent"
    anchors.centerIn: parent
    radius: Theme.rounding
    Text{
      text: "notifications"
      color: Theme.color.fg
      font.family: Theme.font.family.material
      font.pointSize: Theme.font.size.large
      font.bold: true
      anchors.centerIn: parent
    }
    MouseArea {
      id: mouse
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true
      onClicked: (mouse) => {
        if (mouse.button == Qt.MiddleButton) {
          Hyprland.dispatch("global buppyshell:clearNotifs");
        } else {
          Hyprland.dispatch("global buppyshell:toggleSidebar");
        }
      }
    }
  }
}
