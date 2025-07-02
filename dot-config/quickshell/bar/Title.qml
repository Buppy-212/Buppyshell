import Quickshell
import Quickshell.Widgets
import QtQuick
import "root:/services"

Rectangle {
  width: text.width
  height: Theme.blockHeight
  color: "transparent"
  StyledText {
    id: text
    text: Hyprland.title
    width: contentWidth
    Behavior on width {
      animation: Theme.animation.elementMoveFast.numberAnimation.createObject(this)
    }
  }
}
