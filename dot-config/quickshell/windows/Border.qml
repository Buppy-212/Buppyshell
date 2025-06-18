import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import "root:/services"
import "root:/windows"

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
      Rectangle {
        id: rect
        color: Theme.color.black
        anchors.fill: parent
        visible: false
      }
      Item {
        id: mask

        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
          anchors.fill: parent
          anchors.margins: Theme.border
          radius: Theme.rounding
        }
      }
      MultiEffect {
        anchors.fill: parent
        maskEnabled: true
        maskInverted: true
        maskSource: mask
        source: rect
        maskThresholdMin: 0.5
        maskSpreadAtMin: 1
      }
    }
  }
}
