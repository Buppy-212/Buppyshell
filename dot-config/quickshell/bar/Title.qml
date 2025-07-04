import Quickshell
import QtQuick
import "root:/services"

Block {
  implicitWidth: Screen.width * 0.5
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
  MouseBlock {
    id: mouse
    onClicked: Hyprland.dispatch("global buppyshell:windows")
  }
}
