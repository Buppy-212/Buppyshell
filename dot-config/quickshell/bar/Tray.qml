import Quickshell.Services.SystemTray
import QtQuick
import "root:/services"

Item {
  id: root
  readonly property Repeater items: items
  clip: true
  visible: width > 0 && height > 0
  implicitWidth: layout.implicitWidth + 2
  implicitHeight: Theme.blockHeight
  MouseBlock {
    onEntered: Hyprland.refreshTitle()
  }
  Row {
    id: layout
    anchors.centerIn: parent
    height: Theme.blockHeight - 2
    Repeater {
      id: items
      model: SystemTray.items
      TrayItem {}
    }
  }
}
