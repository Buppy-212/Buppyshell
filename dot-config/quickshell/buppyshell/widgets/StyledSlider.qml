pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.services

Slider {
    id: slider
    property color color: Theme.color.blue
    property int backgroundOpacity: 1
    live: false
    snapMode: Slider.SnapOnRelease
    stepSize: 0.05
    from: 0
    to: 1
    background: ClippingRectangle {
        anchors.fill: parent
        color: Theme.color.grey
        radius: height / 2
        Rectangle {
            width: slider.visualPosition * slider.availableWidth
            height: parent.height
            color: slider.color
            opacity: slider.backgroundOpacity
            radius: height / 2
        }
    }
}
