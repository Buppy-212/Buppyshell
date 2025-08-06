pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.services

Slider {
    id: root
    property color color: Theme.color.blue
    property int backgroundOpacity: 1
    snapMode: Slider.SnapOnRelease
    stepSize: 0.01
    from: 0
    to: 1
    background: ClippingRectangle {
        anchors.fill: parent
        color: Theme.color.grey
        radius: height / 2
        Rectangle {
            width: root.visualPosition * root.availableWidth
            height: parent.height
            color: root.color
            opacity: root.backgroundOpacity
            radius: height / 2
        }
    }
}
