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
    implicitWidth: 400
    implicitHeight: 100
    color: Theme.color.bg
    radius: Theme.rounding
    border.width: 2
    border.color: Theme.color.blue
    Row {
      x: 16
      anchors.verticalCenter: parent.verticalCenter
      Image {
        source: modelData.appIcon ?? ""
        width: 48
        height: 48
        visible: source !== ""
      }
      Column {
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
      onClicked: modelData.dismiss()  
    } 
  }
}
