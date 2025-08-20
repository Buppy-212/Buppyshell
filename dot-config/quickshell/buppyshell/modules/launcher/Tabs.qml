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

            function scrolled(event): void {
                var i = GlobalState.launcherModule;
                if (event.angleDelta.y < 0) {
                    i += 1;
                    if (i > 4) {
                        i = 0;
                    }
                } else {
                    i -= 1;
                    if (i < 0) {
                        i = 4;
                    }
                }
                GlobalState.launcherModule = i;
            }

            scrollable: true
            selected: GlobalState.launcherModule == launcherModule
            text: delegateButton._text
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.pixelSize: Theme.font.size.doubled
        }
    }
}
