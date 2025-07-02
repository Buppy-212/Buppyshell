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
    text: Hyprland.title
    width: parent.width
    horizontalAlignment: Text.AlignHCenter
    elide: Text.ElideRight
    Behavior on text {
      SequentialAnimation {
        NumberAnimation {
          target: text
          property: "scale"
          to: 0
          duration: Theme.animation.elementMoveExit.duration
          easing.type: Theme.animation.elementMoveExit.type
          easing.bezierCurve: Theme.animation.elementMoveExit.bezierCurve
        }
        PropertyAction {}
        NumberAnimation {
          target: text
          property: "scale"
          to: 1
          duration: Theme.animation.elementMoveEnter.duration
          easing.type: Theme.animation.elementMoveEnter.type
          easing.bezierCurve: Theme.animation.elementMoveEnter.bezierCurve
        }
      }
    }
  }
}
