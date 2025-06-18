import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import "root:/services"

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
      Rectangle {
        id: rect
        readonly property int size: Screen.name === "eDP-1" ? Theme.font.size.extraLarge : Theme.font.size.huge
        x: Screen.name === "eDP-1" ? Screen.width * 0.86 : Screen.width * 0.83
        anchors.verticalCenter: parent.verticalCenter
        Text {
          id: day
          text: Time.day
          font.pointSize: rect.size
          font.family: Theme.font.family.serif
          font.bold: true
          font.italic: true
          color: Theme.color.fg
          anchors.verticalCenter: parent.verticalCenter
        }
        Text {
          text: Time.date
          font.pointSize: rect.size * 0.45
          font.family: Theme.font.family.serif
          font.bold: true
          font.italic: true
          color: Theme.color.fg
          anchors.top: day.bottom
          anchors.horizontalCenter: day.horizontalCenter
        }
      }
    }
  }
}
