import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import "root:/services"

Scope {
  id: root
  property bool visible: false
  LazyLoader {
    id: loader
    loading: visible
    component: PanelWindow {
      id: sidebar
      visible: root.visible
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.namespace: "buppyshell:sidebar"
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
      implicitWidth: Theme.notification.sidebarWidth
      Rectangle {
        radius: Theme.rounding
        color: Theme.color.black
        anchors.fill: parent
        List {}
      }
    }
  }
  GlobalShortcut {
    name: "sidebar"
    description: "Toggle sidebar"
    appid: "buppyshell"
    onPressed: {
      root.visible = !root.visible;
    }
  }
}
