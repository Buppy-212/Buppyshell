import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import "root:/services"
import "."

Scope {
  id: root
  property bool visible: false
  Loader {
    id: loader
    active: visible
    sourceComponent: PanelWindow {
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
      implicitWidth: 440
      Rectangle {
        radius: Theme.rounding
        color: Theme.color.black
        anchors.fill: parent
        List {}
      }
    }
  }
  GlobalShortcut {
    name: "toggleSidebar"
    description: "Toggle sidebar"
    triggerDescription: "Super+N"
    appid: "buppyshell"
    onPressed: {
      root.visible = !root.visible;
    }
  }
}
