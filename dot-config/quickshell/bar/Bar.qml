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
      WlrLayershell.namespace: "buppyshell:leftbar"
      anchors {
        top: true
        left: true
        bottom: true
      }
      implicitWidth: Theme.blockWidth
      color: Theme.color.black
      Column {
        anchors.top: parent.top
        Os {}
        Workspaces {}
      }
      Column {
        anchors.bottom: parent.bottom
        spacing: Theme.border
        Volume {}
        Inhibitor {}
        Battery {}
        Light {}
        Update {}
        Clock {}
        Power {}
      }
    }
    PanelWindow {
      screen: scope.modelData
      WlrLayershell.namespace: "buppyshell:rightbar"
      anchors {
        top: true
        right: true
        bottom: true
      }
      implicitWidth: Theme.blockWidth
      color: Theme.color.black
      Column {
        anchors.top: parent.top
        Bell {}
        Bluetooth {}
      }
    }
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
      Tray {anchors.left: parent.left}
      Title { anchors.centerIn: parent }
      Row {
        id: rightBlocks
        anchors.right: parent.right
      }
    }
  }
}
