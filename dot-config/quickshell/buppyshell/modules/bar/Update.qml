import Quickshell
import QtQuick
import "../../services"
import "../../widgets"

Block {
    id: updateWidget
    visible: Updates.updates == 0 ? false : true
    hovered: mouse.containsMouse
    implicitHeight: mouse.containsMouse ? Theme.blockHeight * 2 : Theme.blockHeight
    StyledText {
        text: `${Updates.updates}`
        anchors.centerIn: undefined
        anchors.top: updateWidget.top
        anchors.horizontalCenter: updateWidget.horizontalCenter
        visible: mouse.containsMouse
    }
    SymbolText {
        text: "system_update_alt"
        anchors.centerIn: undefined
        anchors.bottom: updateWidget.bottom
        anchors.horizontalCenter: updateWidget.horizontalCenter
    }
    MouseBlock {
        id: mouse
        onClicked: Quickshell.execDetached(["floatty", "update"])
    }
    Behavior on implicitHeight {
        animation: Theme.animation.elementMove.numberAnimation.createObject(this)
    }
}
