import QtQuick
import QtQuick.Controls
import qs.services

Control {
    id: root
    property string text
    property color color: Theme.color.fg
    font {
        pixelSize: Theme.font.size.normal
        family: Theme.font.family.mono
        bold: true
    }
    function tapped(eventPoint, button) {
    }
    function scrolled(event) {
    }
    implicitWidth: Theme.width.block
    implicitHeight: Theme.height.block
    contentItem: Text {
        text: root.text
        color: root.color
        font: root.font
        anchors.fill: root
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        id: background
        color: Theme.color.grey
        radius: Theme.radius.normal
        opacity: root.hovered && !tapHandler.pressed ? 1 : 0
        Behavior on opacity {
            animation: Theme.animation.elementMove.numberAnimation.createObject(this)
        }
    }
    HoverHandler {
        cursorShape: Qt.PointingHandCursor
    }
    WheelHandler {
        id: wheelHandler
        onWheel: event => root.scrolled(event)
    }
    TapHandler {
        id: tapHandler
        cursorShape: Qt.PointingHandCursor
        longPressThreshold: 0
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        onTapped: (eventPoint, button) => root.tapped(eventPoint, button)
    }
}
