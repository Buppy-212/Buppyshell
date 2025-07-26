pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Wayland
import qs.services
import qs.widgets
import qs.modules.launcher
import qs.modules.bar

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
            opacity: 0.9
        }
        ColumnLayout {
            anchors.fill: parent
            spacing: Theme.margin.large
            Searchbar {
                id: searchbar
                forwardTargets: [windowSwitcher, logout, appLauncher]
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                Layout.preferredHeight: Theme.height.block * 4
            }
            WindowSwitcher {
                id: windowSwitcher
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                search: searchbar.search
                visible: GlobalState.launcherModule == GlobalState.LauncherModule.Windows
            }
            Logout {
                id: logout
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                visible: GlobalState.launcherModule == GlobalState.LauncherModule.Logout
            }
            AppLauncher {
                id: appLauncher
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                search: searchbar.search
                visible: GlobalState.launcherModule == GlobalState.LauncherModule.Apps
            }
            Taskbar {
                Layout.preferredHeight: Theme.iconSize.big
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            }
        }
    }
}
