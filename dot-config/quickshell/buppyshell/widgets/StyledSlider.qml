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
        anchors.fill: parent
        color: Theme.color.black
        radius: height / 2
        Rectangle {
            id: slider
            width: root.visualPosition * root.availableWidth
            height: parent.height
            color: Theme.color.blue
            radius: height / 2
        }
    }
}
