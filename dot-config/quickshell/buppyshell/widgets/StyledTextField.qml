import QtQuick
import QtQuick.Controls
import qs.services

TextField {
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    color: Theme.color.fg
    placeholderTextColor: Theme.color.fg
    implicitHeight: 50
    implicitWidth: 250
    font {
        pixelSize: height / 2
        family: Theme.font.family.mono
        bold: true
    }
    background: Rectangle {
        color: Theme.color.bgalt
        radius: height / 2
    }
}
