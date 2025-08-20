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

            function tapped(): void {
                GlobalState.sidebarModule = delegateButton.sidebarModule;
            }

            function scrolled(event): void {
                var i = GlobalState.sidebarModule;
                if (event.angleDelta.y < 0) {
                    i += 1;
                    if (i > 3) {
                        i = 0;
                    }
                } else {
                    i -= 1;
                    if (i < 0) {
                        i = 3;
                    }
                }
                GlobalState.sidebarModule = i;
            }

            scrollable: true
            selected: GlobalState.sidebarModule == sidebarModule
            text: delegateButton._text
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.pixelSize: Theme.font.size.doubled
        }
    }
}
