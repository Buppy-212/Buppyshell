import Quickshell
import Quickshell.Wayland
import QtQuick
import "root:/services"
import "root:/modules/notifications"

Scope {
  id: root
  property bool visible: false
  Server {
    id: notificationServer
  }
  PanelWindow {
    id: sidebar
    visible: root.visible
    WlrLayershell.layer: WlrLayer.Overlay
    anchors {
      right: true
      top: true
      bottom: true
    }
    margins {
      right: Theme.border
      top: Theme.border
      bottom: Theme.border
    }
    color: "transparent"
    exclusiveZone: 0
    implicitWidth: 420
    Rectangle {
      radius: Theme.rounding
      color: Theme.color.bg
      anchors.fill: parent
      List {notificationModel: notificationServer.trackedNotifications}
      MouseArea {  
        anchors.fill: parent  
        cursorShape: Qt.PointingHandCursor
        onClicked:{ 
          var notifications = notificationServer.trackedNotifications.values.slice()
          for (var i = 0; i < notifications.length; i++) {
            notifications[i].dismiss()
          }
          root.visible = false
        }
      } 
    }
  }
}
