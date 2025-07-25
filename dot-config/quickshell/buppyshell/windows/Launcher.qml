import Quickshell
import QtQuick
import Quickshell.Wayland
import qs.services
import qs.modules.launcher

Scope {
    LazyLoader {
        loading: GlobalState.overlay
        component: PanelWindow {
            visible: GlobalState.overlay
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "buppyshell:launcher"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
            color: Theme.color.bgTranslucent
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                onClicked: GlobalState.overlay = false
            }
            anchors {
                top: true
                right: true
                bottom: true
                left: true
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
}
