import Quickshell
import Quickshell.Widgets
import "../services"

Block {
    id: root
    hovered: mouse.containsMouse
    IconImage {
        implicitSize: Theme.blockHeight - Theme.border
        anchors.centerIn: parent
        source: Qt.resolvedUrl("root:/assets/archlinux.svg")
    }
    MouseBlock {
        id: mouse
        onClicked: Quickshell.execDetached(["uwsm", "app", "--", "rofi-wrapper", "drun", "menu"])
    }
}
