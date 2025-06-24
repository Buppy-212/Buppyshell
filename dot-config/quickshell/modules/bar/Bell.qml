import Quickshell
import QtQuick
import "root:/services"
import "root:/widgets"
import "root:/windows"

Item {
  implicitWidth: block.width
  implicitHeight: block.height
  BarBlock {
    id: block
    anchors.centerIn: parent
    BarText{
      text: ""
      font.pointSize: Theme.font.size.large
    }
    function onClicked(): void {
      Hyprland.dispatch("global buppyshell:toggleSidebar");
    }
  }
}
