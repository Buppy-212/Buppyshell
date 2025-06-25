import "root:/services"
import "root:/widgets"
import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
  id: root
  readonly property var process: Process {
    command: ["rofi", "-show", "drun", "-config", "~/.config/rofi/menu.rasi"]
  }
  implicitWidth: 30
  implicitHeight: 24
  color: mouse.containsMouse ? Theme.color.gray : "transparent"
  radius: Theme.rounding
  Image {
    fillMode: Image.PreserveAspectCrop
    sourceSize.width: 22
    sourceSize.height: 22
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
