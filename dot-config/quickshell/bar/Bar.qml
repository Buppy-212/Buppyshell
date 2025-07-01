import Quickshell
import Quickshell.Wayland
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
        left: true
        right: true
      }
      implicitHeight: Theme.blockHeight
      color: Theme.color.black
      RowLayout {
        id: hBlocks
        anchors.fill: parent
        RowLayout {
          id: leftBlocks
          Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
          Os {}
          Title {}
        }
        RowLayout {
          id: rightBlocks
          Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
          Tray {}
          Bell {}
        }
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
      ColumnLayout {
        id: vBlocks
        anchors.fill: parent
        Workspaces {Layout.alignment: Qt.AlignHCenter | Qt.AlignTop}
        ColumnLayout {
          id: bottomBlocks
          Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
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
}
