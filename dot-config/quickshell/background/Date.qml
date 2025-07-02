import Quickshell
import QtQuick
import "root:/services"

Rectangle {
  id: rect
  readonly property int size: Screen.name === "eDP-1" ? Theme.font.size.extraLarge : Theme.font.size.huge
  anchors.verticalCenter: parent.verticalCenter
  anchors.leftMargin: Screen.name === "eDP-1" ? Screen.width * 0.84 : Screen.width * 0.755
  anchors.fill: parent
  color: "transparent"
  Column {
    id: column
    anchors.centerIn: rect
    height: day.height + date.height
    width: day.width
    spacing: Theme.border
    Text {
      id: day
      text: Time.day
      font.pointSize: rect.size
      font.family: Theme.font.family.handwritten
      font.bold: true
      font.italic: true
      color: Theme.color.fg
      anchors.horizontalCenter: column.horizontalCenter
    }
    Text {
      id: date
      text: Time.date
      font.pointSize: rect.size * 0.45
      font.family: Theme.font.family.handwritten
      font.bold: true
      font.italic: true
      color: Theme.color.fg
      anchors.horizontalCenter: column.horizontalCenter
    }
  }
}
