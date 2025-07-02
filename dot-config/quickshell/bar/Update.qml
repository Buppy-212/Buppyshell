import Quickshell
import QtQuick
import "root:/services"

Block {
  id: root
  visible: Updates.updates == 0 ? false : true
  implicitHeight: mouse.containsMouse ? Theme.blockHeight*2 : Theme.blockHeight
  StyledText{
    text: `${Updates.updates}`
    anchors.centerIn: undefined
    anchors.top: root.top
    anchors.horizontalCenter: root.horizontalCenter
    visible: mouse.containsMouse
  }
  SymbolText{
    text: "system_update_alt"
    anchors.centerIn: undefined
    anchors.bottom: root.bottom
    anchors.horizontalCenter: root.horizontalCenter
  }
  MouseBlock {
    id: mouse
    onClicked: Hyprland.dispatch("exec floatty update")
  }
  Behavior on implicitHeight {
    animation: Theme.animation.elementMove.numberAnimation.createObject(this)
  }
}
