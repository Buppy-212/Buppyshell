import QtQuick
import qs.services

GridView {
    id: root
    property alias background: background.sourceComponent
    required model
    required delegate
    clip: true
    snapMode: GridView.SnapToRow
    highlightFollowsCurrentItem: true
    highlightMoveDuration: 100
    highlight: Rectangle {
        color: Theme.color.grey
        radius: width / 4
    }
    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_H:
            root.moveCurrentIndexLeft();
            break;
        case Qt.Key_J:
            root.moveCurrentIndexDown();
            break;
        case Qt.Key_K:
            root.moveCurrentIndexUp();
            break;
        case Qt.Key_L:
            root.moveCurrentIndexRight();
            break;
        case Qt.Key_N:
            root.moveCurrentIndexRight();
            break;
        case Qt.Key_P:
            root.moveCurrentIndexLeft();
            break;
        case Qt.Key_Tab:
            root.moveCurrentIndexRight();
            break;
        case Qt.Key_Backtab:
            root.moveCurrentIndexLeft();
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
            radius: Theme.radius.normal
        }
    }
}
