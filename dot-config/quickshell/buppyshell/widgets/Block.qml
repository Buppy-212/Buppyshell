import QtQuick
import "../services"

Rectangle {
    property bool hovered: false
    implicitWidth: Theme.width.block
    implicitHeight: Theme.height.block
    color: hovered ? Theme.color.grey : "transparent"
    radius: Theme.radius.normal
}
