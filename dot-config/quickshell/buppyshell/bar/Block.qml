import QtQuick
import "../services"

Rectangle {
    property bool hovered: false
    implicitWidth: Theme.blockWidth
    implicitHeight: Theme.blockHeight
    color: hovered ? Theme.color.grey : "transparent"
    radius: Theme.rounding
}
