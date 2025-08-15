pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.services

Slider {
    id: root
    property alias color: slider.color
    snapMode: Slider.SnapOnRelease
    stepSize: 0.01
    from: 0
    to: 1
    background: ClippingRectangle {
        color: Theme.color.black
        radius: height / 2
        Rectangle {
            id: slider
            implicitWidth: root.visualPosition * root.availableWidth
            implicitHeight: parent.height
            color: Theme.color.blue
            radius: height / 2
        }
    }
    HoverHandler {
        cursorShape: root.pressed ? Qt.ClosedHandCursor : Qt.PointingHandCursor
    }
}
