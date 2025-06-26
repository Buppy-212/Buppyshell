import Quickshell
import Quickshell.Widgets
import QtQuick
import "root:/services"

ClippingRectangle {
  width: text.width
  height: Theme.blockHeight
  color: "transparent"
  StyledText {
    id: text
    text: Hyprland.title
  }
  Behavior on width {
    animation: Theme.animation.elementMoveFast.numberAnimation.createObject(this)
  }
}
