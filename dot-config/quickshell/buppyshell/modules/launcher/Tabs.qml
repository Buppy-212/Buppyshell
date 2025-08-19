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
                _text: "󰵆",
                launcherModule: GlobalState.LauncherModule.AppLauncher,
                command: "notifications"
            },
            {
                _text: "󰖯",
                launcherModule: GlobalState.LauncherModule.WindowSwitcher,
                command: "volume"
            },
            {
                _text: "󰃀",
                launcherModule: GlobalState.LauncherModule.BookmarkLauncher,
                command: "volume"
            },
            {
                _text: "󰐥",
                launcherModule: GlobalState.LauncherModule.Logout,
                command: "bluetooth"
            },
        ]
        delegate: StyledTabButton {
            id: delegateButton

            required property string _text
            required property string command
            required property int launcherModule

            function tapped(): void {
                GlobalState.launcherModule = delegateButton.launcherModule;
            }

            selected: GlobalState.launcherModule == launcherModule
            text: delegateButton._text
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.pixelSize: Theme.font.size.doubled
        }
    }
}
