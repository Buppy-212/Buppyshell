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
        anchors.top: updateWidget.top
        anchors.horizontalCenter: updateWidget.horizontalCenter
        visible: mouse.containsMouse
    }
    StyledText {
        text: ""
        anchors.bottom: updateWidget.bottom
        anchors.horizontalCenter: updateWidget.horizontalCenter
    }
    MouseBlock {
        id: mouse
        onClicked: Quickshell.execDetached(["floatty", "update"])
    }
}
