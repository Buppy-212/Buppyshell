import QtQuick
import Quickshell
import QtQuick.Controls
import Quickshell.Services.Notifications
import "root:/services"


ListView {
  id: notificationList
  required property var notificationModel
  anchors.top: parent.top
  anchors.bottom: parent.bottom
  width: parent.width - 25
  anchors.horizontalCenter: parent.horizontalCenter
  model: notificationModel
  spacing: Theme.border
  delegate: Rectangle {
    id: rect
    implicitWidth: row.width > 400 ? row.width : 400
    implicitHeight: row.height > 100 ? row.height : 100
    color: Theme.color.bg
    radius: Theme.rounding
    border.width: 2
    border.color: Theme.color.blue
    Row {
      id: row
      x: 16
      width: column.width
      height: column.height
      anchors.verticalCenter: parent.verticalCenter
      Image {
        source: modelData.appIcon ?? ""
        width: 48
        height: 48
        visible: source !== ""
      }
      Column {
        id: column
        width: summary.width > body.width ? summary.width : body.width
        height: summary.height + body.height
        anchors.verticalCenter: parent.verticalCenter
        Text {
          id: summary
          text: modelData.summary ?? ""
          font.pointSize: Theme.font.size.large
          font.bold: true
          color: Theme.color.fg
        }
        Text {
          id: body
          text: modelData.body ?? ""
          font.pointSize: Theme.font.size.normal
          color: Theme.color.fg
        }
      }
      Image {
        source: modelData.image ?? ""
        width: 48
        height: 48
        visible: source !== ""
      }
    }
    MouseArea {  
      anchors.fill: parent  
      cursorShape: Qt.PointingHandCursor
      onClicked: modelData.dismiss()  
    } 
  }
}
