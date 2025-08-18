import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.services

ColumnLayout {
    id: root
    spacing: 0
    Header {
        title: "Network"
        Layout.fillWidth: true
        Layout.maximumHeight: Screen.height / 30
    }
    Rectangle {
        id: networkWidget
        color: Theme.color.bgalt
        radius: Theme.radius
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.rightMargin: root.width / 16
        Layout.leftMargin: root.width / 16
    }
}
