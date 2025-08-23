import QtQuick
import qs.services
import qs.widgets

Item {
    id: root

    Column {
        anchors.fill: parent
        anchors.leftMargin: root.height / 12
        Text {
            id: shortDate

            height: parent.height / 3
            text: `${Time.date}`
            color: "black"
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
                    topMargin: Theme.margin
                    leftMargin: Theme.margin
                }
                color: Theme.color.fg
                text: parent.text
                style: Text.Outline
                styleColor: "black"
                font: parent.font
            }
        }

        Text {
            id: day

            text: Time.day
            color: "black"
            height: parent.height / 8
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
                    topMargin: Theme.margin
                    leftMargin: Theme.margin
                }
                text: parent.text
                color: Theme.color.fg
                style: Text.Outline
                styleColor: "black"
                font: parent.font
            }
        }
        Text {
            id: time

            text: `${Time.time}`
            x: width
            height: parent.height / 10
            color: "black"
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
                    leftMargin: Theme.margin
                }
                horizontalAlignment: Font.AlignRight
                text: parent.text
                color: Theme.color.fg
                style: Text.Outline
                styleColor: "black"
                font: parent.font
            }
        }
    }
}
