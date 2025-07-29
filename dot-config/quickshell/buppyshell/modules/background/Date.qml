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
        Item {
            implicitHeight: parent.height / 4
            implicitWidth: parent.width
            StyledText {
                text: Time.date
                font {
                    pixelSize: parent.width / 10
                    family: Theme.font.family.handwritten
                    italic: true
                }
            }
        }
        Item {
            implicitHeight: parent.height / 2
            implicitWidth: parent.width
            StyledText {
                text: Time.time
                font.pixelSize: parent.width / 4
            }
        }
    }
}
