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
    StyledButton {
        Layout.preferredHeight: Theme.height.doubleBlock
        Layout.preferredWidth: height
        text: Bluetooth.defaultAdapter?.enabled ?? Bluetooth.adapters.values[0]?.enabled ? "󰂯" : "󰂲"
        color: Theme.color.blue
        font.pixelSize: height * 0.75
        function tapped() {
            Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
        }
    }
    StyledText {
        id: adapterName
        Layout.preferredHeight: Theme.height.doubleBlock
        Layout.fillWidth: true
        text: Bluetooth.defaultAdapter?.name ?? Bluetooth.adapters.values[0]?.name ?? ""
        font.pixelSize: height * 0.75
    }
    StyledButton {
        Layout.preferredHeight: Theme.height.doubleBlock
        Layout.preferredWidth: height
        text: Bluetooth.defaultAdapter?.discovering ?? Bluetooth.adapters.values[0]?.discovering ? "󰜺" : ""
        color: Theme.color.fg
        font.pixelSize: height * 0.75
        function tapped() {
            Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering;
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
            delegate: StyledButton {
                id: bluetoothItem
                required property BluetoothDevice modelData
                color: modelData.connected ? Theme.color.accent : Theme.color.fg
                width: parent.width
                height: 36
                contentItem: RowLayout {
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
                        color: bluetoothItem.color
                    }
                    StyledText {
                        Layout.alignment: Qt.AlignRight
                        Layout.fillHeight: true
                        Layout.preferredWidth: contentWidth
                        Layout.rightMargin: height / 4
                        text: bluetoothItem.modelData.trusted ? "Trusted" : ""
                        color: bluetoothItem.color
                    }
                }
                function tapped(pointEvent, button) {
                    switch (button) {
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
