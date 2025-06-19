import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "root:/services"
import "root:/widgets"

ColumnLayout {
  Column {
    spacing: 4
    Repeater {
      model: Hyprland.workspaces
      BarBlock {
        id: workspaceCell
        required property int index
        property bool focused: Hyprland.activeWsId === (index + 1)
        property bool occupied: Hyprland.workspaces[index].windows > 0
        implicitWidth: 26
        implicitHeight: 30
        radius: Theme.rounding
        color: focused === true ? Theme.color.yellow : occupied === true ? Theme.color.gray : Theme.color.black
        BarText {
          id: workspaceText
          text: index === 9 ? 0 : (index + 1).toString()
          color: focused === true ? Theme.color.black : Theme.color.fg
        }
        function onClicked(): void {
          Hyprland.dispatch(`workspace ${index+1}`)
        }
      }
    }
  }
}
