import Quickshell.Widgets
import qs.services
import qs.widgets

StyledButton {
    id: root
    contentItem: IconImage {
        anchors {
            fill: parent
            margins: 1
        }
        source: Qt.resolvedUrl("root:/assets/archlinux.svg")
    }
    function tapped(): void {
        GlobalState.launcherModule == GlobalState.LauncherModule.Apps ? GlobalState.launcher = !GlobalState.launcher : GlobalState.launcher = true;
        GlobalState.launcherModule = GlobalState.LauncherModule.Apps;
    }
}
