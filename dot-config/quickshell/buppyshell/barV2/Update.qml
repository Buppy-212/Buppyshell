import Quickshell
import QtQuick
import "../services"
import "../widgets"

Block {
    id: updateWidget
    visible: Updates.updates == 0 ? false : true
    hovered: mouse.containsMouse
    implicitWidth: mouse.containsMouse ? Theme.blockWidth * 2 : Theme.blockWidth
    Row {
        StyledText {
            text: `${Updates.updates}`
            anchors.centerIn: undefined
            visible: mouse.containsMouse
        }
        StyledText {
            text: ""
            anchors.centerIn: undefined
        }
    }
    MouseBlock {
        id: mouse
        onClicked: Quickshell.execDetached(["floatty", "update"])
    }
    Behavior on implicitHeight {
        animation: Theme.animation.elementMove.numberAnimation.createObject(this)
    }
}
