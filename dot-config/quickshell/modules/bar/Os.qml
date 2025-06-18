import "root:/services"
import "root:/widgets"
import Quickshell
import Quickshell.Io
import QtQuick

BarBlock {
  Image {
    fillMode: Image.PreserveAspectCrop
    sourceSize.width: 22
    sourceSize.height: 22
    anchors.centerIn: parent
    source: Qt.resolvedUrl("root:/assets/archlinux.svg")
  }
  readonly property var process: Process {
    command: ["rofi", "-show", "drun", "-config", "~/.config/rofi/menu.rasi"]
  }
  function onClicked(): void {
    process.startDetached();
  }
}
