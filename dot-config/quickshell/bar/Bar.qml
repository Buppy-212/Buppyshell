import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "root:/services"

Variants {
  model: Quickshell.screens
  Scope {
    id: scope
    property var modelData
    PanelWindow {
      screen: scope.modelData
      id: bar
      WlrLayershell.namespace: "buppyshell:topbar"
      anchors {
        top: true
        right: true
        left: true
      }
      implicitHeight: Theme.blockHeight
      color: Theme.color.black
      Os { anchors.left: parent.left }
      Title { anchors.centerIn: parent }
      Row {
        id: rightBlocks
        spacing: Theme.border
        anchors.right: parent.right
        Tray {}
        Bell {}
      }
    }
    PanelWindow {
      screen: scope.modelData
      WlrLayershell.namespace: "buppyshell:leftbar"
      anchors {
        top: true
        left: true
        bottom: true
      }
      implicitWidth: Theme.blockWidth
      color: Theme.color.black
      Workspaces {anchors.top: parent.top; anchors.topMargin: Theme.border}
      Column {
        spacing: Theme.border
        anchors.bottom: parent.bottom
        Bluetooth {}
        Volume {}
        Inhibitor {}
        Battery {}
        Light {}
        Update {}
        Clock {}
        Power {}
      }
    }
  }
}
