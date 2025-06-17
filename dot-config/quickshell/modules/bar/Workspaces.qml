import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "root:/services"
import "root:/widgets"

ColumnLayout {
  Column {
    spacing: 8
    Repeater {
      model: 10
      BarBlock {
        id: workspaceCell
        required property int index
        property bool focused: Hyprland.activeWsId === (index + 1)
        implicitWidth: 26
        implicitHeight: 30
        radius: Theme.rounding
        color: focused === true ? Theme.color.yellow : Theme.color.black
        BarText {
          id: workspaceText
          text: index === 9 ? 0 : (index + 1).toString()
          color: focused === true ? Theme.color.black : Theme.color.fg
        }
        readonly property var process: Process {
          command: ["hyprctl", "dispatch", "workspace", index+1]
        }
        function onClicked(): void {
          process.startDetached();
        }
      }
    }
  }
}
