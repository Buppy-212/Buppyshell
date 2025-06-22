import "root:/services"
import "root:/widgets"
import Quickshell
import Quickshell.Io
import QtQuick

BarBlock {
  implicitWidth: text.width
  BarText {
    id: text
    text: Hyprland.title ?? "Desktop"
    anchors.centerIn: undefined
  }
  readonly property var process: Process {
    command: ["rofi", "-show", "window", "-config", "~/.config/rofi/menu.rasi"]
  }
  function onClicked(): void {
    process.startDetached();
  }
}
