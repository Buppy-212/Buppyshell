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
                launcherModule: GlobalState.LauncherModule.AppLauncher
            },
            {
                _text: "󰖯",
                launcherModule: GlobalState.LauncherModule.WindowSwitcher
            },
            {
                _text: "󰃀",
                launcherModule: GlobalState.LauncherModule.BookmarkLauncher
            },
            {
                _text: "󰸉",
                launcherModule: GlobalState.LauncherModule.WallpaperSwitcher
            },
            {
                _text: "󰐥",
                launcherModule: GlobalState.LauncherModule.Logout
            },
        ]
        delegate: StyledTabButton {
            id: delegateButton

            required property string _text
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
