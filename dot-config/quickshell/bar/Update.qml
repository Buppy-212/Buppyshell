import Quickshell
import Quickshell.Io
import QtQuick
import "root:/services"
import "."

Block {
  id: root
  property bool hovered: false
  readonly property var process: Process {
    command: ["floatty", "update"]
  }
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
    onClicked: process.startDetached();
  }
  Behavior on implicitHeight {
    animation: Theme.animation.elementMove.numberAnimation.createObject(this)
  }
}
