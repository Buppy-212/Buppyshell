import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import "root:/services"

ListView {
  Server {
    id: notificationServer
  }
  id: notificationList
  anchors.top: parent.top
  anchors.topMargin: Theme.border*4
  anchors.bottom: parent.bottom
  width: Theme.notification.width
  anchors.horizontalCenter: parent.horizontalCenter
  model: notificationServer.trackedNotifications
  spacing: Theme.border*2
  delegate: Item {
    implicitWidth: content.width
    implicitHeight: content.height
    Content {id: content; notification: modelData}
  }
  removeDisplaced:Transition{
    NumberAnimation {
      property: "y"
      duration: Theme.animation.elementMoveFast.duration
      easing.type: Theme.animation.elementMoveFast.type
      easing.bezierCurve: Theme.animation.elementMoveFast.bezierCurve
    }
  }
}
