import Quickshell
import Quickshell.Io
import QtQuick
import "root:/services"

Rectangle {
  id: root
  readonly property var process: Process {
    command: ["rofi", "-show", "drun", "-config", "~/.config/rofi/menu.rasi"]
  }
  implicitWidth: Theme.blockWidth
  implicitHeight: Theme.blockHeight
  color: mouse.containsMouse ? Theme.color.gray : "transparent"
  radius: Theme.rounding
  Image {
    fillMode: Image.PreserveAspectCrop
    sourceSize.width: Theme.blockHeight - Theme.border
    sourceSize.height: Theme.blockHeight - Theme.border
    anchors.centerIn: parent
    source: Qt.resolvedUrl("root:/assets/archlinux.svg")
  }
  MouseArea {
    id: mouse
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    anchors.fill: parent
    onClicked: process.startDetached() 
  }
}
