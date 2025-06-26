import Quickshell
import Quickshell.Io
import QtQuick
import "root:/services"

Rectangle {
  id: root
  property bool hovered: false
  readonly property var process: Process {
    command: ["floatty", "update"]
  }
  visible: Updates.updates == 0 ? false : true
  implicitHeight: mouse.containsMouse ? Theme.blockHeight*2 : Theme.blockHeight
  implicitWidth: Theme.blockWidth
  color: mouse.containsMouse ? Theme.color.gray : "transparent"
  radius: Theme.rounding
  Text{
    text: `${Updates.updates}`
    anchors.top: root.top
    anchors.horizontalCenter: root.horizontalCenter
    font.bold: true
    font.pointSize: Theme.font.size.normal
    font.family: Theme.font.family.mono
    color: Theme.color.fg
    visible: mouse.containsMouse
  }
  Text{
    text: "system_update_alt"
    anchors.bottom: root.bottom
    anchors.horizontalCenter: root.horizontalCenter
    font.bold: true
    font.pointSize: Theme.font.size.normal
    font.family: Theme.font.family.material
    color: Theme.color.fg
  }
  MouseArea {
    id: mouse
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    onClicked: process.startDetached();
  }
  Behavior on implicitHeight {
    animation: Theme.animation.elementMove.numberAnimation.createObject(this)
  }
}
