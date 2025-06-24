import Quickshell
import QtQuick
import Quickshell.Wayland
import "root:/services"
import "root:/widgets"

Scope {
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: win
      required property ShellScreen modelData
      screen: modelData
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
        source: Theme.wallpaper
      }
      RoundCorner {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 30
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
        anchors.topMargin: 24
        anchors.leftMargin: 30
        size: Theme.rounding*1.5
        corner: cornerEnum.topLeft
      }
      RoundCorner {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 24
        size: Theme.rounding*1.5
        corner: cornerEnum.topRight
      }
      Rectangle {
        id: rect
        readonly property int size: Screen.name === "eDP-1" ? Theme.font.size.extraLarge : Theme.font.size.huge
        x: Screen.name === "eDP-1" ? Screen.width * 0.90 : Screen.width * 0.865
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: 100
        implicitHeight: 1
        color: "transparent"
        Column {
          id: column
          anchors.centerIn: rect
          spacing: Theme.border
          Text {
            id: day
            text: Time.day
            font.pointSize: rect.size
            font.family: Theme.font.family.serif
            font.bold: true
            font.italic: true
            color: Theme.color.fg
            anchors.horizontalCenter: column.horizontalCenter
          }
          Text {
            id: date
            text: Time.date
            font.pointSize: rect.size * 0.45
            font.family: Theme.font.family.serif
            font.bold: true
            font.italic: true
            color: Theme.color.fg
            anchors.horizontalCenter: column.horizontalCenter
          }
        }
      }
    }
  }
}
