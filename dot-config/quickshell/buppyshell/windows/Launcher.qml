pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Widgets
import qs.services
import qs.widgets
import qs.modules.launcher

LazyLoader {
    loading: GlobalState.launcher
    component: PanelWindow {
        visible: GlobalState.launcher
        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.namespace: "buppyshell:launcher"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
        exclusionMode: ExclusionMode.Ignore
        color: Theme.color.black
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
            onClicked: GlobalState.launcher = false
        }
        anchors {
            top: true
            right: true
            bottom: true
            left: true
        }
        Image {
            id: background
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: Wallpaper.path
            visible: false
        }
        MultiEffect {
            autoPaddingEnabled: false
            source: background
            anchors.fill: background
            blur: 1
            blurMax: 64
            blurEnabled: true
        }
        Rectangle {
            anchors.fill: parent
            color: Theme.color.bg
            opacity: 0.85
        }
        ColumnLayout {
            id: column
            anchors.fill: parent
            spacing: Theme.margin.large
            Searchbar {
                id: searchbar
                forwardTargets: [windowSwitcher, logout, appLauncher]
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                Layout.preferredHeight: Theme.height.block * 4
            }
            WrapperItem {
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                WindowSwitcher {
                    id: windowSwitcher
                    search: searchbar.search
                }
                Logout {
                    id: logout
                }
                AppLauncher {
                    id: appLauncher
                    search: searchbar.search
                }
                child: {
                    switch (GlobalState.launcherModule) {
                    case GlobalState.LauncherModule.Apps:
                        return appLauncher;
                        break;
                    case GlobalState.LauncherModule.Logout:
                        return logout;
                        break;
                    case GlobalState.LauncherModule.Windows:
                        return windowSwitcher;
                        break;
                    default:
                        return null;
                    }
                }
            }
            Taskbar {
                id: taskbar
                Layout.preferredHeight: Theme.iconSize.big
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            }
        }
    }
}
