pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.modules.bar
import qs.services

Rectangle {
    id: rightRect
    property bool enableTray: true
    color: Theme.color.black
    implicitHeight: parent.height
    implicitWidth: Theme.width.block
    anchors.right: parent.right
    ColumnLayout {
        anchors.fill: parent
        Column {
            spacing: Theme.margin.tiny
            Layout.alignment: Qt.AlignTop
            Bell {}
            Volume {}
            Bluetooth {}
            Network {}
            Player {}
            Loader {
                id: loader
                active: rightRect.enableTray
                sourceComponent: tray
            }
        }
    }
    Component {
        id: tray
        Tray {
            relativeY: loader.y
        }
    }
}
