import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

RowLayout {
    id: root
    spacing: 0
    uniformCellSizes: true
    Repeater {
        id: repeater
        model: [
            {
                _text: "󰂚",
                sidebarModule: GlobalState.SidebarModule.Notifications,
                command: "notifications"
            },
            {
                _text: "",
                sidebarModule: GlobalState.SidebarModule.Volume,
                command: "volume"
            },
            {
                _text: "󰂯",
                sidebarModule: GlobalState.SidebarModule.Bluetooth,
                command: "bluetooth"
            },
            {
                _text: "󰖩",
                sidebarModule: GlobalState.SidebarModule.Network,
                command: "network"
            },
        ]
        delegate: StyledTabButton {
            id: delegateButton
            required property string _text
            required property string command
            required property int sidebarModule
            selected: GlobalState.sidebarModule == sidebarModule
            text: delegateButton._text
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.pixelSize: height * 0.75
            function tapped(): void {
                GlobalState.toggle(delegateButton.command);
            }
        }
    }
}
