import QtQuick
import qs.services

ListView {
    id: root
    property alias background: background.sourceComponent
    required model
    required delegate
    spacing: 0
    Loader {
        id: background
        anchors.fill: parent
        asynchronous: true
        z: -1
        sourceComponent: Rectangle {
            color: Theme.color.bgalt
            radius: Theme.radius.normal
        }
    }
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
    highlightFollowsCurrentItem: true
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
        }
    }
}
