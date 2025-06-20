import QtQuick
import Quickshell
import QtQuick.Controls
import Quickshell.Services.Notifications
import "root:/services"


ListView {
  id: notificationList
  required property var notificationModel
  anchors.top: parent.top
  anchors.topMargin: Theme.border*4
  anchors.bottom: parent.bottom
  width: parent.width - 25
  anchors.horizontalCenter: parent.horizontalCenter
  model: notificationModel
  spacing: Theme.border*2
  delegate: Rectangle {
    id: rect
    implicitWidth: 420
    implicitHeight: row.height > 60 ? row.height + 20 : 80
    color: Theme.color.bg
    radius: Theme.rounding
    border.width: 2
    border.color: Theme.color.blue
    Row {
      id: row
      x: 16
      spacing: 16
      width: column.width
      height: column.height
      anchors.verticalCenter: parent.verticalCenter
      Image {
        source: modelData.appIcon !== "" ? Quickshell.iconPath(modelData.appIcon) : ""
        width: 48
        height: 48
        visible: modelData.appIcon !== "" ? true : false
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
          text: modelData.summary ?? ""
          font.pointSize: Theme.font.size.large
          font.bold: true
          color: Theme.color.fg
        }
        Text {
          id: body
          wrapMode: Text.Wrap
          width: column.width
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
        anchors.verticalCenter: column.verticalCenter
      }
    }
    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: modelData.dismiss()
    } 
  }
}
