pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

ColumnLayout {
    id: root
    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_O:
            listView.currentItem.tapped(undefined, Qt.LeftButton);
            break;
        case Qt.Key_T:
            listView.currentItem.tapped(undefined, Qt.RightButton);
            break;
        case Qt.Key_D:
            listView.currentItem.tapped(undefined, Qt.MiddleButton);
            break;
        case Qt.Key_B:
            header.leftButtonTapped();
            break;
        case Qt.Key_S:
            header.rightButtonTapped();
            break;
        case Qt.Key_Return:
            listView.currentItem.tapped(undefined, Qt.LeftButton);
            break;
        }
    }
    Keys.forwardTo: [listView]
    Header {
        id: header
        Layout.fillWidth: true
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
    StyledListView {
        id: listView
        Layout.fillWidth: true
        Layout.fillHeight: true
        model: Bluetooth.devices
        delegate: StyledTabButton {
            id: delegate
            required property BluetoothDevice modelData
            required property int index
            function entered(): void {
                listView.currentIndex = delegate.index;
            }
            function tapped(eventPoint, button): void {
                switch (button) {
                case Qt.LeftButton:
                    !delegate.modelData.paired ? delegate.modelData.pair() : delegate.modelData.connected ? delegate.modelData.disconnect() : delegate.modelData.connect();
                    break;
                case Qt.MiddleButton:
                    delegate.modelData.paired ? delegate.modelData.forget() : delegate.modelData.cancelPair();
                    break;
                case Qt.RightButton:
                    delegate.modelData.trusted = !delegate.modelData.trusted;
                    break;
                }
            }
            accentColor: selected ? Theme.color.black : Theme.color.accent
            selected: modelData.connected
            implicitWidth: listView.width
            implicitHeight: 48
            background: Rectangle {
                visible: delegate.selected
                color: Theme.color.accent
                radius: height / 4
            }
            contentItem: RowLayout {
                anchors.fill: parent
                spacing: height / 4
                IconImage {
                    Layout.fillHeight: true
                    Layout.preferredWidth: height
                    source: Quickshell.iconPath(delegate.modelData.icon, "bluetooth")
                }
                StyledText {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    text: delegate.modelData.batteryAvailable ? `${delegate.modelData.name} (${delegate.modelData.battery * 100}%)` : delegate.modelData.name
                    color: delegate.ListView.isCurrentItem ? delegate.accentColor : delegate.buttonColor
                    font.pixelSize: height / 2
                    fontSizeMode: Text.Fit
                }
                StyledText {
                    Layout.alignment: Qt.AlignRight
                    Layout.fillHeight: true
                    Layout.preferredWidth: contentWidth
                    Layout.rightMargin: height / 4
                    visible: delegate.modelData.trusted
                    font.pixelSize: height / 2
                    text: ""
                    color: Theme.color.green
                }
            }
        }
    }
}
