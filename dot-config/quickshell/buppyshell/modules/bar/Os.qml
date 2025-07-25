import Quickshell
import Quickshell.Widgets
import qs.services
import qs.widgets

Block {
    id: root
    hovered: mouse.containsMouse
    IconImage {
        implicitSize: Theme.height.block - Theme.margin.tiny
        anchors.centerIn: parent
        source: Qt.resolvedUrl("root:/assets/archlinux.svg")
    }
    MouseBlock {
        id: mouse
        onClicked: {
            GlobalState.launcherModule == GlobalState.LauncherModule.Apps ? GlobalState.launcher = !GlobalState.launcher : GlobalState.launcher = true
            GlobalState.launcherModule = GlobalState.LauncherModule.Apps
        }
    }
}
