import "root:/services"
import "root:/widgets"
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick

ClippingRectangle {
  width: text.width
  height: 24
  color: "transparent"
  BarText {
    id: text
    text: Hyprland.title ?? "Desktop"
  }
  Behavior on width {
    animation: Theme.animation.elementMoveFast.numberAnimation.createObject(this)
  }
}
