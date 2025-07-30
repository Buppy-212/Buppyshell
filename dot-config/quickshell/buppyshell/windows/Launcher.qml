pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Wayland
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
            anchors {
                fill: parent
                topMargin: spacing / 2
            }
            spacing: parent.height / 24
            Searchbar {
                id: searchbar
                forwardTargets: [loader.item]
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                Layout.preferredHeight: Screen.height / 24
            }
            Loader {
                id: loader
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                sourceComponent: {
                    switch (GlobalState.launcherModule) {
                    case GlobalState.LauncherModule.Apps:
                        return appLauncher;
                        break;
                    case GlobalState.LauncherModule.Windows:
                        return windowSwitcher;
                        break;
                    case GlobalState.LauncherModule.Logout:
                        return logout;
                        break;
                    default:
                        return undefined;
                    }
                }
            }
            Component {
                id: appLauncher
                AppLauncher {
                    search: searchbar.search
                }
            }
            Component {
                id: windowSwitcher
                WindowSwitcher {
                    search: searchbar.search
                }
            }
            Component {
                id: logout
                Logout {}
            }
            Taskbar {
                id: taskbar
                Layout.preferredHeight: Screen.height / 24
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            }
        }
    }
}
