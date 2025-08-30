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
                icon: "󰂚",
                sidebarModule: GlobalState.SidebarModule.Notifications
            },
            {
                icon: "",
                sidebarModule: GlobalState.SidebarModule.Volume
            },
            {
                icon: "󰂯",
                sidebarModule: GlobalState.SidebarModule.Bluetooth
            },
            {
                icon: "󰖩",
                sidebarModule: GlobalState.SidebarModule.Network
            },
            {
                icon: "",
                sidebarModule: GlobalState.SidebarModule.Updates
            },
        ]
        delegate: StyledTabButton {
            id: delegateButton

            required property string icon
            required property int sidebarModule

            function tapped(): void {
                GlobalState.sidebarModule = delegateButton.sidebarModule;
            }

            function scrolled(event): void {
                var i = GlobalState.sidebarModule;
                if (event.angleDelta.y < 0) {
                    i += 1;
                    if (i > repeater.count - 1) {
                        i = 0;
                    }
                } else {
                    i -= 1;
                    if (i < 0) {
                        i = repeater.count - 1;
                    }
                }
                GlobalState.sidebarModule = i;
            }

            scrollable: true
            selected: GlobalState.sidebarModule === sidebarModule
            text: delegateButton.icon
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.pixelSize: Theme.font.size.doubled
        }
    }
}
