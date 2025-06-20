import Quickshell
import Quickshell.Hyprland
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
    implicitWidth: 440
    Rectangle {
      radius: Theme.rounding
      color: Theme.color.black
      anchors.fill: parent
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
      List {notificationModel: notificationServer.trackedNotifications}
    }
  }
  GlobalShortcut {
    name: "toggleSidebar"
    description: "Toggle sidebar"
    triggerDescription: "Super+N"
    appid: "buppyshell"
    onPressed: {
      root.visible = !root.visible
    }
  }
}
