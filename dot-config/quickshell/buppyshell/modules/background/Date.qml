import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.services
import qs.widgets

ClippingRectangle {
    anchors {
        top: parent.top
        topMargin: parent.height / 50
        horizontalCenter: parent.horizontalCenter
    }
    implicitHeight: parent.height / 10
    implicitWidth: parent.width / 10
    color: "transparent"
    radius: height / 3

    ColumnLayout {
        id: column

        anchors.fill: parent
        spacing: 0

        StyledText {
            Layout.topMargin: column.height / 8
            Layout.fillWidth: true
            Layout.preferredHeight: column.height / 4
            text: Time.date
            font {
                pixelSize: width / 10
                family: Theme.font.family.handwritten
                italic: true
            }
        }

        StyledText {
            Layout.bottomMargin: column.height / 8
            Layout.fillWidth: true
            Layout.preferredHeight: column.height / 2
            text: Time.time
            font.pixelSize: width / 4
        }
    }
}
