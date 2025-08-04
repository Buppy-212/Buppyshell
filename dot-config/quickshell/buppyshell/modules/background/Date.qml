import QtQuick
import qs.modules.bar
import qs.services
import qs.widgets

Rectangle {
    anchors {
        top: parent.top
        topMargin: parent.height / 50
        horizontalCenter: parent.horizontalCenter
    }
    implicitHeight: parent.height / 10
    implicitWidth: parent.width / 10
    color: Theme.color.bgTranslucent
    radius: height / 3
    Column {
        id: column
        anchors.fill: parent
        topPadding: parent.height / 8
        StyledText {
            height: parent.height / 4
            width: parent.width
            text: Time.date
            font {
                pixelSize: width / 10
                family: Theme.font.family.handwritten
                italic: true
            }
        }
        StyledText {
            height: parent.height / 2
            width: parent.width
            text: Time.time
            font.pixelSize: width / 4
        }
    }
}
