import QtQuick
import "../services"

Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: Screen.name === "eDP-1" ? Screen.width * 0.84 : Screen.width * 0.755
    anchors.fill: parent
    color: "transparent"
    Column {
        readonly property int size: Screen.name === "eDP-1" ? Theme.font.size.extraLarge : Theme.font.size.huge
        anchors.centerIn: parent
        height: day.height + date.height
        width: day.width
        spacing: Theme.border
        Text {
            id: day
            text: Time.day
            font.pointSize: parent.size
            font.family: Theme.font.family.handwritten
            font.bold: true
            font.italic: true
            color: Theme.color.fg
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: date
            text: Time.date
            font.pointSize: parent.size * 0.45
            font.family: Theme.font.family.handwritten
            font.bold: true
            font.italic: true
            color: Theme.color.fg
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
