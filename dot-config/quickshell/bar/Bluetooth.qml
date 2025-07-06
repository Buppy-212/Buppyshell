pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Bluetooth
import QtQuick
import "../services"

ClippingRectangle {
    id: bluetoothWidget
    property bool revealed: false
    implicitHeight: revealed ? (Bluetooth.devices.values.length + 1) * 26 : 24
    implicitWidth: Theme.blockWidth
    color: "transparent"
    Behavior on implicitHeight {
        animation: Theme.animation.elementMoveFast.numberAnimation.createObject(this)
    }
    Column {
        spacing: 2
        anchors.fill: parent
        Block {
            hovered: bluetoothMouse.containsMouse
            SymbolText {
                id: text
                text: Bluetooth.defaultAdapter?.enabled ?? Bluetooth.adapters.values[0]?.enabled ? "bluetooth" : "bluetooth_disabled"
                color: Theme.color.blue
            }
            MouseBlock {
                id: bluetoothMouse
                onClicked: mouse => {
                    if (mouse.button == Qt.LeftButton) {
                        Quickshell.execDetached(["uwsm", "app", "--", "floatty", "bluetui"]);
                    } else if (mouse.button == Qt.MiddleButton) {
                        Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
                    } else {
                        bluetoothWidget.revealed = !bluetoothWidget.revealed;
                    }
                }
                onEntered: GlobalState.overrideTitle(Bluetooth.defaultAdapter.name)
                onExited: GlobalState.refreshTitle()
            }
        }
        Repeater {
            model: Bluetooth.devices
            delegate: Block {
                id: bluetoothItem
                required property BluetoothDevice modelData
                visible: bluetoothWidget.revealed
                Behavior on visible {
                    animation: Theme.animation.elementMove.numberAnimation.createObject(this)
                }
                color: mouse.containsMouse ? Theme.color.grey : bluetoothItem.modelData.batteryAvailable && bluetoothItem.modelData.battery <= 0.1 ? Theme.color.red : bluetoothItem.modelData.connected ? Theme.color.accent : "transparent"
                IconImage {
                    anchors.centerIn: parent
                    implicitSize: Theme.blockHeight
                    source: Quickshell.iconPath(bluetoothItem.modelData.icon)
                }
                MouseBlock {
                    id: mouse
                    onClicked: mouse => {
                        if (mouse.button == Qt.LeftButton) {
                            bluetoothItem.modelData.connected ? bluetoothItem.modelData.disconnect() : bluetoothItem.modelData.connect();
                        }
                    }
                    onEntered: {
                        if (bluetoothItem.modelData.batteryAvailable) {
                            GlobalState.overrideTitle(`${bluetoothItem.modelData.name}${bluetoothItem.modelData.battery * 100}%`);
                        } else {
                            GlobalState.overrideTitle(bluetoothItem.modelData.name);
                        }
                    }
                    onExited: GlobalState.refreshTitle()
                }
            }
        }
    }
}
