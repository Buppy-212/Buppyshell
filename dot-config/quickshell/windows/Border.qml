import Quickshell
import Quickshell.Wayland
import QtQuick
import "root:/services"
import "root:/widgets"

Variants {
  model: Quickshell.screens
  Scope {
    property var modelData
    PanelWindow {
      id: border
      screen: modelData
      anchors {
        top: true
        left: true
        bottom: true
        right: true
      }
      exclusionMode: ExclusionMode.Normal
      WlrLayershell.namespace: "border"
      color: "transparent"
      aboveWindows: false
      RoundCorner {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        size: Theme.rounding*1.5
        corner: cornerEnum.bottomLeft
      }
      RoundCorner {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        size: Theme.rounding*1.5
        corner: cornerEnum.bottomRight
      }
      RoundCorner {
        anchors.top: parent.top
        anchors.left: parent.left
        size: Theme.rounding*1.5
        corner: cornerEnum.topLeft
      }
      RoundCorner {
        anchors.top: parent.top
        anchors.right: parent.right
        size: Theme.rounding*1.5
        corner: cornerEnum.topRight
      }
    }
  }
}
