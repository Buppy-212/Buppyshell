import Quickshell
import Quickshell.Widgets
import QtQuick
import "root:/services"

ClippingRectangle {
  width: text.width
  height: Theme.blockHeight
  color: "transparent"
  Text {
    id: text
    text: Hyprland.title
    color: Theme.color.fg
    font.family: Theme.font.family.mono
    font.pointSize: Theme.font.size.normal
    font.bold: true
    anchors.centerIn: parent
  }
  Behavior on width {
    animation: Theme.animation.elementMoveFast.numberAnimation.createObject(this)
  }
}
