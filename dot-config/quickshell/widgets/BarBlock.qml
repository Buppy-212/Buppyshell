import QtQuick
import Quickshell

Rectangle {
  id: root
  implicitWidth: 30
  implicitHeight: 24
  color: "transparent"
  MouseArea {
    id: mouse
    anchors.fill: parent
    cursorShape: root.disabled ? undefined : Qt.PointingHandCursor
    hoverEnabled: true
    onClicked: event => root.onClicked(event)
  }
}
