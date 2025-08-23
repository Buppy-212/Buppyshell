import QtQuick
import qs.services
import qs.widgets

Item {
    id: root

    implicitHeight: parent.height / 4
    implicitWidth: parent.width

    Column {
        anchors.fill: parent
        Text {
            height: parent.height / 3
            text: `\t${Time.date}`
            color: "black"
            transform: Rotation {
                origin.x: 0
                origin.y: root.height / 2
                angle: 45
                axis.x: -1
                axis.y: 1
                axis.z: 0
            }
            font {
                pixelSize: root.height / 2
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
            text: Time.day
            color: "black"
            height: parent.height / 6
            transform: Rotation {
                origin.x: 0
                origin.y: root.height / 2
                angle: 54
                axis.x: -1
                axis.y: 1
                axis.z: 0
            }
            font {
                pixelSize: root.height / 4
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
            text: `${Time.time}`
            x: width
            color: "black"
            transform: Rotation {
                origin.x: 0
                origin.y: 0
                angle: 30
                axis.x: 1
                axis.y: 1
                axis.z: -1
            }
            font {
                pixelSize: root.height / 5
                family: Theme.font.family.mono
                weight: Font.Black
            }
            Text {
                anchors {
                    fill: parent
                    leftMargin: Theme.margin
                }
                text: parent.text
                color: Theme.color.fg
                style: Text.Outline
                styleColor: "black"
                font: parent.font
            }
        }
    }
}
