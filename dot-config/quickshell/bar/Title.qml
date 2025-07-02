import Quickshell
import Quickshell.Widgets
import QtQuick
import "root:/services"

Rectangle {
  width: Screen.width * 0.4
  height: Theme.blockHeight
  color: "transparent"
  StyledText {
    id: text
    property real xScale: 1
    text: Hyprland.title
    width: parent.width
    horizontalAlignment: Text.AlignHCenter
    elide: Text.ElideRight
  }
}
