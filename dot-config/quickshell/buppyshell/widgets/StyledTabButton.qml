import QtQuick
import qs.widgets
import qs.services

StyledButton {
    id: root
    property bool selected: false
    property int borderSide: StyledTabButton.Bottom
    property int borderSize: 1
    enum BorderSide {
        Top,
        Right,
        Bottom,
        Left
    }
    background: Item {
        Rectangle {
            color: Theme.color.grey
            anchors.fill: parent
            radius: Theme.radius.normal
            opacity: (root.hovered || root.dragged) && !root.pressed ? 1 : 0
            Behavior on opacity {
                animation: Theme.animation.elementMove.numberAnimation.createObject(this)
            }
        }
        Rectangle {
            anchors {
                top: root.borderSide !== StyledTabButton.Bottom ? parent.top : undefined
                right: root.borderSide !== StyledTabButton.Left ? parent.right : undefined
                bottom: root.borderSide !== StyledTabButton.Top ? parent.bottom : undefined
                left: root.borderSide !== StyledTabButton.Right ? parent.left : undefined
            }
            radius: Theme.radius.normal
            visible: root.selected
            color: Theme.color.accent
            implicitHeight: root.borderSize
            implicitWidth: root.borderSize
        }
    }
}
