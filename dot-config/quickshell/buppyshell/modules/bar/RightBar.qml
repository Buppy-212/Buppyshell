import QtQuick
import QtQuick.Layouts
import qs.modules.bar
import qs.services

Rectangle {
    id: rightRect
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
            Tray {}
        }
    }
}
