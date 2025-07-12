import QtQuick
import "../../widgets"
import "../../services"

Rectangle {
    color: Theme.color.bg
    Rectangle {
        id: title
        anchors.top: parent.top
        implicitWidth: parent.width
        implicitHeight: 48
        color: Theme.color.bg
        radius: Theme.rounding
        StyledText {
            text: "Network"
            font.pointSize: 26
        }
    }
    Rectangle {
        id: networkWidget
        color: Theme.color.bgalt
        radius: Theme.rounding
        anchors {
            margins: 36
            topMargin: title.height
            fill: parent
        }
    }
}
