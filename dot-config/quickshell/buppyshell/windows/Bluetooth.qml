import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets
import QtQuick
import "../services"
import "../widgets"

Rectangle {
    id: bluetoothWidget
    implicitWidth: 600
    implicitHeight: 320
    visible: GlobalState.bluetooth
    radius: Theme.rounding
    color: Theme.color.bg
    Block {
        hovered: adapterMouse.containsMouse
        anchors.top: parent.top
        anchors.left: parent.left
        implicitHeight: 48
        implicitWidth: 36
        StyledText {
            text: Bluetooth.defaultAdapter.enabled ? "󰂯" : "󰂲"
            color: Theme.color.blue
            font.pointSize: 26
        }
        MouseBlock {
            id: adapterMouse
            onClicked: Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled
        }
    }
    Block {
        hovered: searchMouse.containsMouse
        anchors.top: parent.top
        anchors.right: parent.right
        implicitHeight: 48
        implicitWidth: 48
        StyledText {
            text: Bluetooth.defaultAdapter.discovering ? "󰜺" : ""
            color: Theme.color.fg
            font.pointSize: 26
        }
        MouseBlock {
            id: searchMouse
            onClicked: Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering
        }
    }
    Item {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        implicitHeight: 48
        implicitWidth: adapterName.contentWidth
        StyledText {
            id: adapterName
            text: Bluetooth.defaultAdapter.name
            font.pointSize: 26
        }
    }
    GridView {
        anchors.fill: parent
        anchors.topMargin: 72
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        anchors.bottomMargin: 36
        cellWidth: parent.width / 2 - 12
        cellHeight: 28
        model: Bluetooth.devices
        delegate: Block {
            id: bluetoothItem
            required property BluetoothDevice modelData
            hovered: itemMouse.containsMouse
            implicitWidth: row.width
            color: itemMouse.containsMouse ? Theme.color.grey : modelData.batteryAvailable && modelData.battery <= 0.1 ? Theme.color.red : modelData.connected ? Theme.color.accent : "transparent"
            Row {
                id: row
                width: name.width + 40
                anchors.fill: parent
                anchors.leftMargin: 2
                spacing: 8
                IconImage {
                    implicitSize: parent.height
                    source: Quickshell.iconPath(bluetoothItem.modelData.icon, "bluetooth")
                }
                StyledText {
                    id: name
                    text: bluetoothItem.modelData.batteryAvailable ? `${bluetoothItem.modelData.name} ${bluetoothItem.modelData.battery * 100}%` : bluetoothItem.modelData.name
                    anchors.centerIn: undefined
                }
            }
            MouseBlock {
                id: itemMouse
                onClicked: mouse => {
                    if (mouse.button == Qt.LeftButton) {
                        !bluetoothItem.modelData.paired ? bluetoothItem.modelData.pair() : bluetoothItem.modelData.connected ? bluetoothItem.modelData.disconnect() : bluetoothItem.modelData.connect();
                    } else {
                        bluetoothItem.modelData.paired ? bluetoothItem.modelData.forget() : bluetoothItem.modelData.cancelPair();
                    }
                }
            }
        }
    }
}
