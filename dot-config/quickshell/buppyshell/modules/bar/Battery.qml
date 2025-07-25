import Quickshell
import Quickshell.Services.UPower
import qs.services
import qs.widgets

Block {
    hovered: mouse.containsMouse
    StyledText {
        text: Math.round(UPower.displayDevice.percentage * 100)
        color: Theme.color.green
    }
    MouseBlock {
        id: mouse
        onClicked: Quickshell.execDetached(["uwsm", "app", "--", "btop.desktop"])
    }
}
