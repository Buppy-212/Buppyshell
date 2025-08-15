import QtQuick
import QtQuick.Controls
import qs.services

Control {
    id: root
    property alias text: text.text
    property alias scrollable: wheelHandler.enabled
    readonly property alias buttonColor: text.color
    readonly property alias pressed: tapHandler.pressed
    property color color: Theme.color.fg
    property color accentColor: root.color
    property bool dragged: false
    function entered(): void {
    }
    function exited(): void {
    }
    function tapped(eventPoint, button): void {
    }
    function scrolled(event): void {
    }
    implicitWidth: Theme.width.block
    implicitHeight: Theme.height.block
    font {
        pixelSize: Theme.font.size.normal
        family: Theme.font.family.mono
        bold: true
    }
    contentItem: Text {
        id: text
        anchors.fill: parent
        color: root.hovered ? root.accentColor : root.color
        font: root.font
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        color: Theme.color.grey
        radius: Theme.radius.normal
        opacity: (root.hovered || root.dragged) && !root.pressed ? 1 : 0
        Behavior on opacity {
            animation: Theme.animation.elementMove.numberAnimation.createObject(this)
        }
    }
    HoverHandler {
        cursorShape: Qt.PointingHandCursor
        onHoveredChanged: hovered ? root.entered() : root.exited()
    }
    WheelHandler {
        id: wheelHandler
        enabled: false
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        onWheel: event => root.scrolled(event)
    }
    TapHandler {
        id: tapHandler
        longPressThreshold: 0
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        onTapped: (eventPoint, button) => root.tapped(eventPoint, button)
    }
}
