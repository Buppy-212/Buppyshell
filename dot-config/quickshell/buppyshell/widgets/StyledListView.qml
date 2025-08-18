import QtQuick
import qs.services

ListView {
    id: root
    property alias background: background.sourceComponent
    required model
    required delegate
    snapMode: ListView.SnapToItem
    spacing: 0
    clip: true
    highlightFollowsCurrentItem: true
    highlightMoveDuration: 100
    highlightResizeDuration: 0
    highlight: Rectangle {
        color: Theme.color.grey
        radius: height / 4
    }
    removeDisplaced: Transition {
        NumberAnimation {
            property: "y"
            duration: Theme.animation.elementMoveFast.duration
            easing.type: Theme.animation.elementMoveFast.type
            easing.bezierCurve: Theme.animation.elementMoveFast.bezierCurve
        }
    }
    keyNavigationWraps: true
    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_J:
            root.incrementCurrentIndex();
            break;
        case Qt.Key_K:
            root.decrementCurrentIndex();
            break;
        case Qt.Key_N:
            root.incrementCurrentIndex();
            break;
        case Qt.Key_P:
            root.decrementCurrentIndex();
            break;
        case Qt.Key_Tab:
            root.incrementCurrentIndex();
            break;
        case Qt.Key_Backtab:
            root.decrementCurrentIndex();
            break;
        }
    }
    Loader {
        id: background
        anchors.fill: parent
        asynchronous: true
        z: -1
        sourceComponent: Rectangle {
            color: Theme.color.bgalt
            radius: Theme.radius
        }
    }
}
