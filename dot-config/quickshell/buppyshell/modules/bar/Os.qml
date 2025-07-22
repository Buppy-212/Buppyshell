import Quickshell
import Quickshell.Widgets
import "../../services"
import "../../widgets"

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
        onClicked: Quickshell.execDetached(["uwsm", "app", "--", "rofi-wrapper", "drun", "menu"])
    }
}
