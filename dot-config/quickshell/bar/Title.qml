import Quickshell
import Quickshell.Widgets
import QtQuick
import "root:/services"

Rectangle {
  width: Screen.width * 0.5
  height: Theme.blockHeight
  color: "transparent"
  StyledText {
    id: text
    property real xScale: 1
    text: Hyprland.title
    width: parent.width
    horizontalAlignment: Text.AlignHCenter
    elide: Text.ElideRight
    transform: Scale { origin.x: text.width/2; xScale: text.xScale }
    Behavior on text {
      SequentialAnimation {
        NumberAnimation {
          target: text
          property: "xScale"
          to: 0
          duration: Theme.animation.elementMoveExit.duration
          easing.type: Theme.animation.elementMoveExit.type
          easing.bezierCurve: Theme.animation.elementMoveExit.bezierCurve
        }
        PropertyAction {}
        NumberAnimation {
          target: text
          property: "xScale"
          to: 1
          duration: Theme.animation.elementMoveEnter.duration
          easing.type: Theme.animation.elementMoveEnter.type
          easing.bezierCurve: Theme.animation.elementMoveEnter.bezierCurve
        }
      }
    }
  }
}
