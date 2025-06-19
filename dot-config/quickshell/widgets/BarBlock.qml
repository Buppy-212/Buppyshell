import QtQuick
import Quickshell

Rectangle {
  id: root
  property bool disabled: false
  property bool containsMouse: mouse.containsMouse
  implicitWidth: 30
  implicitHeight: 24
  color: "transparent"
  MouseArea {
    id: mouse
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: root.disabled ? undefined : Qt.PointingHandCursor
    hoverEnabled: true
    onClicked: event => root.onClicked(event)
  }
}
