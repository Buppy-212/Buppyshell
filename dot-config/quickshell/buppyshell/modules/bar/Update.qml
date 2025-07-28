import Quickshell
import QtQuick
import qs.services
import qs.widgets

Block {
    id: updateWidget
    visible: Updates.updates == 0 ? false : true
    hovered: mouse.containsMouse
    implicitHeight: mouse.containsMouse ? Theme.height.doubleBlock : Theme.height.block
    StyledText {
        text: `${Updates.updates}`
        anchors.centerIn: undefined
        anchors.top: updateWidget.top
        anchors.horizontalCenter: updateWidget.horizontalCenter
        visible: mouse.containsMouse
        anchors.fill: undefined
    }
    StyledText {
        text: ""
        anchors.bottom: updateWidget.bottom
        anchors.horizontalCenter: updateWidget.horizontalCenter
        anchors.fill: undefined
    }
    MouseBlock {
        id: mouse
        onClicked: Quickshell.execDetached(["floatty", "update"])
    }
}
