import QtQuick
import qs.widgets
import qs.services

StyledButton {
    id: root
    property bool selected: false
    property int borderSide: StyledTabButton.Bottom
    property int borderSize: 3
    enum BorderSide {
        Top,
        Right,
        Bottom,
        Left
    }
    background: Item {
        Rectangle {
            anchors.fill: parent
            topRightRadius: root.borderSide === StyledTabButton.Right || root.borderSide === StyledTabButton.Top ? 0 : Theme.radius.normal
            topLeftRadius: root.borderSide === StyledTabButton.Left || root.borderSide === StyledTabButton.Top ? 0 : Theme.radius.normal
            bottomRightRadius: root.borderSide === StyledTabButton.Right || root.borderSide === StyledTabButton.Bottom ? 0 : Theme.radius.normal
            bottomLeftRadius: root.borderSide === StyledTabButton.Left || root.borderSide === StyledTabButton.Bottom ? 0 : Theme.radius.normal
            color: Theme.color.grey
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
            radius: root.borderSize
            color: root.selected ? Theme.color.accent : Theme.color.bgalt
            implicitHeight: root.borderSize
            implicitWidth: root.borderSize
        }
    }
}
