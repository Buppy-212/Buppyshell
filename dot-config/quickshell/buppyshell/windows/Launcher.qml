pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
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
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
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
        LeftBar {}
        RoundCorner {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: Theme.width.block
            size: Theme.radius.normalAdjusted
            corner: cornerEnum.bottomLeft
        }
        RoundCorner {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: Theme.width.block
            size: Theme.radius.normalAdjusted
            corner: cornerEnum.topLeft
        }
        RightBar {}
        RoundCorner {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: Theme.width.block
            size: Theme.radius.normalAdjusted
            corner: cornerEnum.bottomRight
        }
        RoundCorner {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: Theme.width.block
            size: Theme.radius.normalAdjusted
            corner: cornerEnum.topRight
        }
        WindowSwitcher {
            visible: GlobalState.launcherModule == GlobalState.LauncherModule.Windows
        }
        Logout {
            visible: GlobalState.launcherModule == GlobalState.LauncherModule.Logout
        }
        AppLauncher {
            visible: GlobalState.launcherModule == GlobalState.LauncherModule.Apps
        }
    }
}
