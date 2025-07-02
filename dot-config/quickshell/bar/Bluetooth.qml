import Quickshell
import Quickshell.Widgets
import Quickshell.Bluetooth
import QtQuick
import "root:/services"

ClippingRectangle {
  id: root
  property bool revealed: false
  implicitHeight: revealed ? (Bluetooth.devices.values.length + 1) * 26 : 26
  implicitWidth: Theme.blockWidth
  color: "transparent"
  Behavior on implicitHeight {
    animation: Theme.animation.elementMoveFast.numberAnimation.createObject(this)
  }
  MouseBlock {
    onEntered: {
      Hyprland.refreshTitle();
    }
  }
  Column {
    anchors.fill: parent
    anchors.topMargin: 1
    width: Theme.blockWidth - Theme.border
    Repeater {
      model: Bluetooth.devices
      delegate: Block {
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: Theme.blockWidth - Theme.border
        implicitHeight: Theme.blockHeight + Theme.border
        visible: revealed
        Behavior on visible {
          animation: Theme.animation.elementMove.numberAnimation.createObject(this)
        }
        color: mouse.containsMouse ? Theme.color.gray : modelData.batteryAvailable && modelData.battery <= 0.1 ? Theme.color.red : modelData.connected ? Theme.color.accent : "transparent"
        IconImage {
          anchors.centerIn: parent
          implicitSize: Theme.blockHeight
          source: Quickshell.iconPath(modelData.icon)
        }
        MouseBlock {
          id: mouse
          onClicked: (mouse) => {
            if (mouse.button == Qt.LeftButton) {
              modelData.connected ? modelData.disconnect() : modelData.connect();
            }
          }
          onEntered: {
            if (modelData.batteryAvailable) {
              Hyprland.overrideTitle(`${modelData.name}${modelData.battery*100}%`);
            } else {
              Hyprland.overrideTitle(modelData.name);
            }
          }
        }
      }
    }
    Block {
      anchors.horizontalCenter: parent.horizontalCenter
      implicitWidth: Theme.blockWidth - Theme.border
      SymbolText {
        id: text
        text: Bluetooth.defaultAdapter?.enabled ? "bluetooth" : "bluetooth_disabled"
        color: Theme.color.blue
      }
      MouseBlock {
        id: mouse
        onClicked: (mouse) => {
          if (mouse.button == Qt.LeftButton) {
            Hyprland.dispatch("exec uwsm app -- floatty bluetui");
          } else if (mouse.button == Qt.MiddleButton) {
            Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
          } else {
            root.revealed = !root.revealed;
          }
        }
      }
    }
  }
}
