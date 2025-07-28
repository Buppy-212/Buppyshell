pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

Rectangle {
    id: bluetoothWidget
    radius: Theme.radius.normal
    color: Theme.color.bg
    Block {
        hovered: adapterMouse.containsMouse
        anchors.top: parent.top
        anchors.left: parent.left
        implicitHeight: Theme.height.doubleBlock
        implicitWidth: implicitHeight
        StyledText {
            text: Bluetooth.defaultAdapter?.enabled ?? Bluetooth.adapters.values[0]?.enabled ? "󰂯" : "󰂲"
            color: Theme.color.blue
            font.pixelSize: Theme.font.size.doubled
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
        implicitHeight: Theme.height.doubleBlock
        implicitWidth: implicitHeight
        StyledText {
            text: Bluetooth.defaultAdapter?.discovering ?? Bluetooth.adapters.values[0]?.discovering ? "󰜺" : ""
            color: Theme.color.fg
            font.pixelSize: Theme.font.size.doubled
        }
        MouseBlock {
            id: searchMouse
            onClicked: Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering
        }
    }
    Item {
        id: adapterNameItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        implicitHeight: Theme.height.doubleBlock
        implicitWidth: adapterName.contentWidth
        StyledText {
            id: adapterName
            text: Bluetooth.defaultAdapter?.name ?? Bluetooth.adapters.values[0]?.name ?? ""
            font.pixelSize: Theme.font.size.doubled
        }
    }
    Rectangle {
        anchors.fill: parent
        anchors.margins: 36
        anchors.topMargin: adapterNameItem.height
        radius: Theme.radius.normal
        color: Theme.color.bgalt
        ListView {
            spacing: 8
            anchors.fill: parent
            anchors.margins: 12
            model: Bluetooth.devices
            delegate: Block {
                id: bluetoothItem
                required property BluetoothDevice modelData
                hovered: itemMouse.containsMouse
                implicitWidth: parent.width
                implicitHeight: 36
                color: itemMouse.containsMouse ? Theme.color.grey : modelData.batteryAvailable && modelData.battery <= 0.1 ? Theme.color.red : modelData.connected ? Theme.color.accent : "transparent"
                RowLayout {
                    anchors.fill: parent
                    Row {
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillHeight: true
                        spacing: 8
                        IconImage {
                            implicitSize: parent.height
                            source: Quickshell.iconPath(bluetoothItem.modelData.icon, "bluetooth")
                        }
                        StyledText {
                            text: bluetoothItem.modelData.name
                            anchors.fill: undefined
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        StyledText {
                            text: bluetoothItem.modelData.batteryAvailable ? `(${bluetoothItem.modelData.battery * 100}%)` : ""
                            anchors.fill: undefined
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    StyledText {
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 4
                        text: bluetoothItem.modelData.trusted ? "Trusted" : ""
                        anchors.fill: undefined
                    }
                }
                MouseBlock {
                    id: itemMouse
                    onClicked: mouse => {
                        switch (mouse.button) {
                        case Qt.LeftButton:
                            !bluetoothItem.modelData.paired ? bluetoothItem.modelData.pair() : bluetoothItem.modelData.connected ? bluetoothItem.modelData.disconnect() : bluetoothItem.modelData.connect();
                            break;
                        case Qt.MiddleButton:
                            bluetoothItem.modelData.paired ? bluetoothItem.modelData.forget() : bluetoothItem.modelData.cancelPair();
                            break;
                        case Qt.RightButton:
                            bluetoothItem.modelData.trusted = !bluetoothItem.modelData.trusted;
                            break;
                        }
                    }
                }
            }
        }
    }
}
