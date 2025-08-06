import QtQuick
import QtQuick.Controls
import qs.services

Control {
    id: root
    property string text
    property color color: Theme.color.fg
    property color accentColor: root.color
    readonly property color buttonColor: hovered ? accentColor : color
    readonly property bool pressed: tapHandler.pressed
    font {
        pixelSize: Theme.font.size.normal
        family: Theme.font.family.mono
        bold: true
    }
    function entered() {
    }
    function exited() {
    }
    function tapped(eventPoint, button) {
    }
    function scrolled(event) {
    }
    implicitWidth: Theme.width.block
    implicitHeight: Theme.height.block
    contentItem: Text {
        text: root.text
        anchors.fill: root
        color: root.buttonColor
        font: root.font
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        color: Theme.color.grey
        radius: Theme.radius.normal
        opacity: root.hovered && !root.pressed ? 1 : 0
        Behavior on opacity {
            animation: Theme.animation.elementMove.numberAnimation.createObject(this)
        }
    }
    HoverHandler {
        cursorShape: Qt.PointingHandCursor
        onHoveredChanged: hovered ? root.entered() : root.exited()
    }
    WheelHandler {
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
