import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: win
      required property ShellScreen modelData
      screen: modelData
      WlrLayershell.exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Background
      WlrLayershell.namespace: "bg"
      anchors {
        top: true
        bottom: true
        left: true
        right: true
      }
      Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: Qt.resolvedUrl("root:/assets/Frieren.png")
      }
    }
  }
}
