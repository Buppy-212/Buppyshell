import QtQuick
import qs.services

TextInput {
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    color: Theme.color.fg
    font {
        pixelSize: Theme.font.size.normal
        family: Theme.font.family.mono
        bold: true
    }
    HoverHandler {
        cursorShape: Qt.PointingHandCursor
    }
}
