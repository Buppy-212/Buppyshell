import Quickshell.Services.SystemTray
import QtQuick
import "root:/services"

Item {
  id: trayRoot
  readonly property Repeater items: items
  clip: true
  visible: width > 0 && height > 0
  implicitHeight: layout.implicitHeight + 2
  implicitWidth: Theme.blockWidth
  MouseBlock {
    onEntered: Hyprland.refreshTitle()
  }
  Column {
    id: layout
    anchors.centerIn: parent
    width: Theme.blockWidth - 2
    Repeater {
      id: items
      model: SystemTray.items
      TrayItem {}
    }
  }
}
