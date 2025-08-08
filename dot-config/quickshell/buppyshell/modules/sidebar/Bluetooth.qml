pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

ColumnLayout {
    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_J:
            bluetoothList.incrementCurrentIndex();
            break;
        case Qt.Key_K:
            bluetoothList.decrementCurrentIndex();
            break;
        case Qt.Key_N:
            bluetoothList.incrementCurrentIndex();
            break;
        case Qt.Key_P:
            bluetoothList.decrementCurrentIndex();
            break;
        case Qt.Key_O:
            bluetoothList.currentItem.tapped(undefined, Qt.LeftButton);
            break;
        case Qt.Key_T:
            bluetoothList.currentItem.tapped(undefined, Qt.RightButton);
            break;
        case Qt.Key_D:
            bluetoothList.currentItem.tapped(undefined, Qt.MiddleButton);
            break;
        case Qt.Key_B:
            header.leftButtonTapped();
            break;
        case Qt.Key_S:
            header.rightButtonTapped();
            break;
        case Qt.Key_Down:
            bluetoothList.incrementCurrentIndex();
            break;
        case Qt.Key_Up:
            bluetoothList.decrementCurrentIndex();
            break;
        case Qt.Key_Delete:
            bluetoothList.currentItem.modelData.close();
            break;
        case Qt.Key_Escape:
            GlobalState.sidebar = false;
            break;
        case Qt.Key_Return:
            bluetoothList.currentItem.tapped(undefined, Qt.LeftButton);
            break;
        }
    }
    Header {
        id: header
        Layout.fillWidth: true
        Layout.preferredHeight: Theme.height.doubleBlock
        title: Bluetooth.defaultAdapter?.name ?? "Bluetooth"
        leftButtonText: Bluetooth.defaultAdapter?.enabled ?? Bluetooth.adapters.values[0]?.enabled ? "󰂯" : "󰂲"
        leftButtonColor: Theme.color.blue
        function leftButtonTapped(): void {
            Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
        }
        rightButtonText: Bluetooth.defaultAdapter?.discovering ?? Bluetooth.adapters.values[0]?.discovering ? "󰜺" : ""
        function rightButtonTapped(): void {
            Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering;
        }
    }
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
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
            highlight: Rectangle {
                color: Theme.color.grey
                radius: height / 4
            }
            model: Bluetooth.devices
            highlightFollowsCurrentItem: true
            delegate: StyledTabButton {
                id: bluetoothItem
                required property BluetoothDevice modelData
                required property int index
                borderSize: height
                accentColor: selected ? Theme.color.black : Theme.color.accent
                selected: modelData.connected
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
                        color: bluetoothItem.ListView.isCurrentItem ? bluetoothItem.accentColor : bluetoothItem.buttonColor
                    }
                    StyledText {
                        Layout.alignment: Qt.AlignRight
                        Layout.fillHeight: true
                        Layout.preferredWidth: contentWidth
                        Layout.rightMargin: height / 4
                        text: bluetoothItem.modelData.trusted ? "Trusted" : ""
                        color: bluetoothItem.ListView.isCurrentItem ? bluetoothItem.accentColor : bluetoothItem.buttonColor
                    }
                }
                function entered() {
                    bluetoothList.currentIndex = bluetoothItem.index;
                }
                function tapped(eventPoint, button) {
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
