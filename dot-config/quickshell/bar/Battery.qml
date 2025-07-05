import Quickshell.Services.UPower
import "../services"

Block {
    hovered: mouse.containsMouse
    StyledText {
        text: Math.round(UPower.displayDevice.percentage * 100)
        color: Theme.color.green
    }
    MouseBlock {
        id: mouse
        onClicked: Hyprland.dispatch("exec uwsm app -- btop.desktop")
    }
}
