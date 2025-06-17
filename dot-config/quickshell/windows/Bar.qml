import Quickshell
import QtQuick.Layouts
import "root:/modules/bar"
import "root:/services"

Scope {
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: bar
      property var modelData
      screen: modelData
      anchors {
        top: true
        left: true
        right: true
      }
      implicitHeight: 24
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
        }
      }
    }
  }
  Variants {
    model: Quickshell.screens
    PanelWindow {
      property var modelData
      screen: modelData
      anchors {
        top: true
        left: true
        bottom: true
      }
      implicitWidth: 30
      color: Theme.color.black
      ColumnLayout {
        id: vBlocks
        anchors.fill: parent
        ColumnLayout {
          id: topBlocks
          Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
          Workspaces {}
        }
        ColumnLayout {
          id: bottomBlocks
          Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
          Battery {}
          Update {}
          Clock {}
          Power {}
        }
      }
    }
  }
}
