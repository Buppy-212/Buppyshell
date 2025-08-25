import QtQuick
import qs.services

Item {
    id: root

    Column {
        anchors.fill: parent
        anchors.leftMargin: root.height / 12
        Text {
            id: shortDate

            height: parent.height / 3
            text: Time.date
            color: "black"
            renderType: Text.QtRendering
            transform: Rotation {
                origin.x: 0
                origin.y: shortDate.height
                angle: 45
                axis.x: -1
                axis.y: 1
                axis.z: 0
            }
            font {
                pixelSize: height * 4 / 3
                family: Theme.font.family.sans
                weight: Font.Black
            }
            Text {
                anchors {
                    fill: parent
                    topMargin: parent.height / 16
                    leftMargin: parent.height / 16
                }
                text: parent.text
                color: Theme.color.fg
                renderType: Text.QtRendering
                style: Text.Outline
                styleColor: "black"
                font: parent.font
            }
        }

        Text {
            height: parent.height / 8
            text: Time.day
            color: "black"
            renderType: Text.QtRendering
            transform: Rotation {
                origin.x: 0
                origin.y: 0
                angle: 45
                axis.x: -1
                axis.y: 1
                axis.z: 0
            }
            font {
                pixelSize: height * 16 / 9
                family: Theme.font.family.sans
                weight: Font.Black
            }
            Text {
                anchors {
                    fill: parent
                    topMargin: parent.height / 8
                    leftMargin: parent.height / 8
                }
                text: parent.text
                color: Theme.color.fg
                renderType: Text.QtRendering
                style: Text.Outline
                styleColor: "black"
                font: parent.font
            }
        }
        Text {
            height: parent.height / 10
            x: width
            text: Time.time
            color: "black"
            renderType: Text.QtRendering
            horizontalAlignment: Font.AlignRight
            transform: Rotation {
                origin.x: 0
                origin.y: 0
                angle: 30
                axis.x: 1
                axis.y: 1
                axis.z: -1
            }
            font {
                pixelSize: height * 3 / 2
                family: Theme.font.family.mono
                weight: Font.Black
            }
            Text {
                anchors {
                    fill: parent
                    leftMargin: parent.height / 8
                }
                text: parent.text
                color: Theme.color.fg
                renderType: Text.QtRendering
                style: Text.Outline
                styleColor: "black"
                horizontalAlignment: Font.AlignRight
                font: parent.font
            }
        }
    }
}
