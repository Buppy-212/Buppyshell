import Quickshell
import QtQuick
import "root:/services"

Rectangle {
  id: rect
  required property var notification
  implicitWidth: 420
  implicitHeight: row.height > 60 ? row.height + 20 : 80
  color: Theme.color.bg
  radius: Theme.rounding
  border.width: 2
  border.color: Theme.color.blue
  Row {
    id: row
    width: column.width
    height: column.height
    spacing: 16
    x: 16
    anchors.verticalCenter: parent.verticalCenter
    Image {
      source: {
        return Quickshell.iconPath(notification?.appIcon) ?? ""
      }
      width: 48
      height: 48
      visible: notification === null ? "" : notification?.appIcon !== "" ? true : false
      anchors.verticalCenter: column.verticalCenter
    }
    Column {
      id: column
      width: 250
      height: (summary.height + body.height) *1.05
      anchors.verticalCenter: parent.verticalCenter
      Text {
        id: summary
        wrapMode: Text.Wrap
        width: column.width
        text: notification?.summary ?? ""
        font.pointSize: Theme.font.size.large
        font.bold: true
        color: Theme.color.fg
      }
      Text {
        id: body
        wrapMode: Text.Wrap
        width: column.width
        text: notification?.body ?? ""
        font.pointSize: Theme.font.size.normal
        color: Theme.color.fg
      }
    }
    Image {
      source: notification?.image ?? ""
      width: 48
      height: 48
      visible: source !== ""
      anchors.verticalCenter: column.verticalCenter
    }
  }
  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked:{
      notification.dismiss()
      notification = null
      rect.visible = false
    }
  }
}
