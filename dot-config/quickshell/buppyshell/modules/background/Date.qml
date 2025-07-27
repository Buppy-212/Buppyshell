import QtQuick
import qs.modules.bar
import qs.services

Rectangle {
    anchors {
        top: parent.top
        topMargin: Screen.height * 0.02
        horizontalCenter: parent.horizontalCenter
    }
    implicitHeight: column.height * 1.5
    implicitWidth: column.width * 1.5
    color: Theme.color.bgTranslucent
    radius: height
    Column {
        id: column
        height: time.height + date.height
        width: time.width
        anchors.centerIn: parent
        Text {
            id: date
            text: Time.date
            font {
                pixelSize: Screen.width * 0.01
                family: Theme.font.family.handwritten
                bold: true
                italic: true
            }
            color: Theme.color.fg
            width: time.width
            height: contentHeight * 0.8
            horizontalAlignment: Text.AlignHCenter
        }
        Text {
            id: time
            text: Time.time
            font {
                pixelSize: Screen.width * 0.025
                family: Theme.font.family.mono
                bold: true
            }
            color: Theme.color.fg
            width: contentWidth
            height: contentHeight * 0.85
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
