import Quickshell
import QtQuick
import Quickshell.Wayland
import "../services"
import "../modules/launcher"

Scope {
    id: root
    LazyLoader {
        id: loader
        loading: GlobalState.overlay
        component: PanelWindow {
            visible: GlobalState.overlay
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "buppyshell:launcher"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
            exclusionMode: ExclusionMode.Ignore
            color: "#aa222436"
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
            Windows {
              focus: true
              anchors.fill: parent
              visible: GlobalState.launcherModule == GlobalState.LauncherModule.Windows
            }
            Logout {
                focus: true
                anchors.fill: parent
                visible: GlobalState.launcherModule == GlobalState.LauncherModule.Logout
            }
        }
    }
}
