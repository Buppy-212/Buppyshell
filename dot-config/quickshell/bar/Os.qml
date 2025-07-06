import Quickshell.Hyprland
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
        onClicked: Hyprland.dispatch("global buppyshell:launcher")
    }
}
