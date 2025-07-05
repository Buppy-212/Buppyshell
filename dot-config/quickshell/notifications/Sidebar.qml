import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import "root:/services"

PanelWindow {
  id: sidebar
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
