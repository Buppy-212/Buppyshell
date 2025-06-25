import Quickshell
import QtQuick
import "root:/services"
import "root:/widgets"
import "."

Item {
  implicitWidth: block.width
  implicitHeight: block.height
  Rectangle {
    id: block
    implicitWidth: 30
    implicitHeight: 24
    color: mouse.containsMouse ? Theme.color.gray : "transparent"
    anchors.centerIn: parent
    radius: Theme.rounding
    BarText{
      text: ""
      font.pointSize: Theme.font.size.large
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
