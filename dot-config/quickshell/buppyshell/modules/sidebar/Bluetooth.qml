pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

GridLayout {
    id: bluetoothWidget
    columns: 3
    rows: 2
    columnSpacing: 0
    rowSpacing: 0
    Block {
        hovered: adapterMouse.containsMouse
        Layout.preferredHeight: Theme.height.doubleBlock
        Layout.preferredWidth: height
        StyledText {
            text: Bluetooth.defaultAdapter?.enabled ?? Bluetooth.adapters.values[0]?.enabled ? "󰂯" : "󰂲"
            color: Theme.color.blue
            anchors.fill: parent
            font.pixelSize: height * 0.75
        }
        MouseBlock {
            id: adapterMouse
            onClicked: Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled
        }
    }
    StyledText {
        id: adapterName
        Layout.preferredHeight: Theme.height.doubleBlock
        Layout.fillWidth: true
        text: Bluetooth.defaultAdapter?.name ?? Bluetooth.adapters.values[0]?.name ?? ""
        font.pixelSize: height * 0.75
    }
    Block {
        hovered: searchMouse.containsMouse
        Layout.preferredHeight: Theme.height.doubleBlock
        Layout.preferredWidth: height
        StyledText {
            text: Bluetooth.defaultAdapter?.discovering ?? Bluetooth.adapters.values[0]?.discovering ? "󰜺" : ""
            anchors.fill: parent
            color: Theme.color.fg
            font.pixelSize: height * 0.75
        }
        MouseBlock {
            id: searchMouse
            onClicked: Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering
        }
    }
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.columnSpan: 3
        Layout.rightMargin: 36
        Layout.bottomMargin: 36
        Layout.leftMargin: 36
        radius: Theme.radius.normal
        color: Theme.color.bgalt
        ListView {
            id: bluetoothList
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
                    spacing: 8
                    IconImage {
                        Layout.fillHeight: true
                        Layout.preferredWidth: height
                        source: Quickshell.iconPath(bluetoothItem.modelData.icon, "bluetooth")
                    }
                    StyledText {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignLeft
                        text: bluetoothItem.modelData.batteryAvailable ? `${bluetoothItem.modelData.name} (${bluetoothItem.modelData.battery * 100}%)` : bluetoothItem.modelData.name
                    }
                    StyledText {
                        Layout.alignment: Qt.AlignRight
                        Layout.fillHeight: true
                        Layout.preferredWidth: contentWidth
                        Layout.rightMargin: height / 4
                        text: bluetoothItem.modelData.trusted ? "Trusted" : ""
                        font.pixelSize: height / 2
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
