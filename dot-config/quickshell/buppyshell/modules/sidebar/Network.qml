import QtQuick
import qs.widgets
import qs.services

Rectangle {
    color: Theme.color.bg
    Rectangle {
        id: title
        anchors.top: parent.top
        implicitWidth: parent.width
        implicitHeight: Theme.height.doubleBlock
        color: Theme.color.bg
        radius: Theme.radius.normal
        StyledText {
            text: "Network"
            font.pointSize: Theme.font.size.doubled
        }
    }
    Rectangle {
        id: networkWidget
        color: Theme.color.bgalt
        radius: Theme.radius.normal
        anchors {
            margins: 36
            topMargin: title.height
            fill: parent
        }
    }
}
