import "root:/services"
import "root:/widgets"
import Quickshell
import Quickshell.Io
import QtQuick

BarBlock {
  id: root
  property bool hovered: false
  visible: Updates.updates == 0 ? false : true
  implicitHeight: containsMouse ? 48 : 24
  Text{
    text: `${Updates.updates}`
    anchors.top: root.top
    anchors.horizontalCenter: root.horizontalCenter
    font.bold: true
    font.pointSize: Theme.font.size.normal
    font.family: Theme.font.family.mono
    color: Theme.color.fg
    visible: root.containsMouse
  }
  Text{
    text: ``
    anchors.bottom: root.bottom
    anchors.horizontalCenter: root.horizontalCenter
    font.bold: true
    font.pointSize: Theme.font.size.normal
    font.family: Theme.font.family.mono
    color: Theme.color.fg
  }
  readonly property var process: Process {
    command: ["floatty", "update"]
  }
  function onClicked(): void {
    process.startDetached();
  }
  Behavior on implicitHeight {
    animation: Theme.animation.elementMove.numberAnimation.createObject(this)
  }
}
