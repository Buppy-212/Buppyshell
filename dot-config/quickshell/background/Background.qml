import Quickshell
import QtQuick
import Quickshell.Wayland
import "root:/services"

Scope {
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: win
      required property ShellScreen modelData
      screen: modelData
      WlrLayershell.layer: WlrLayer.Background
      WlrLayershell.namespace: "buppyshell:bg"
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
        anchors.leftMargin: Theme.blockWidth
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
        anchors.topMargin: Theme.blockHeight
        anchors.leftMargin: Theme.blockWidth
        size: Theme.rounding*1.5
        corner: cornerEnum.topLeft
      }
      RoundCorner {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: Theme.blockHeight
        size: Theme.rounding*1.5
        corner: cornerEnum.topRight
      }
      Rectangle {
        id: rect
        readonly property int size: Screen.name === "eDP-1" ? Theme.font.size.extraLarge : Theme.font.size.huge
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: Screen.name === "eDP-1" ? Screen.width * 0.855 : Screen.width * 0.77
        anchors.fill: parent
        color: "transparent"
        Column {
          id: column
          anchors.centerIn: rect
          height: day.height + date.height
          width: day.width
          spacing: Theme.border
          Text {
            id: day
            text: Time.day
            font.pointSize: rect.size
            font.family: Theme.font.family.handwritten
            font.bold: true
            font.italic: true
            color: Theme.color.fg
            anchors.horizontalCenter: column.horizontalCenter
          }
          Text {
            id: date
            text: Time.date
            font.pointSize: rect.size * 0.45
            font.family: Theme.font.family.handwritten
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
