import Quickshell
import Quickshell.Widgets
import QtQuick
import "root:/services"

Rectangle {
  required property int screenWidth
  width: screenWidth * 0.5
  height: Theme.blockHeight
  color: "transparent"
  StyledText {
    id: text
    property real xScale: 1
    text: Hyprland.title
    width: parent.width
    horizontalAlignment: Text.AlignHCenter
    elide: Text.ElideRight
    maximumLineCount: 1
  }
}
