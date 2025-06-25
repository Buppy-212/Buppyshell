import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import "root:/services"
import "."

ListView {
  Server {
    id: notificationServer
  }
  id: notificationList
  anchors.top: parent.top
  anchors.topMargin: Theme.border*4
  anchors.bottom: parent.bottom
  width: parent.width - 25
  anchors.horizontalCenter: parent.horizontalCenter
  model: notificationServer.trackedNotifications
  spacing: Theme.border*2
  delegate: Item {
    implicitWidth: content.width
    implicitHeight: content.height
    Content {id: content; notification: modelData}
  }
}
