import QtQuick
import Quickshell
import "root:/services"

Rectangle {
  id: root
  property bool disabled: false
  property bool containsMouse: mouse.containsMouse
  implicitWidth: 30
  implicitHeight: 24
  color: mouse.containsMouse ? Theme.color.gray : "transparent"
  radius: Theme.rounding
  MouseArea {
    id: mouse
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: root.disabled ? undefined : Qt.PointingHandCursor
    hoverEnabled: true
    onClicked: event => root.onClicked(event)
  }
}
