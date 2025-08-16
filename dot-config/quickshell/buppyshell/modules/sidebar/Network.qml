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
        Layout.preferredHeight: Theme.height.doubleBlock
    }
    Rectangle {
        id: networkWidget
        color: Theme.color.bgalt
        radius: Theme.radius.normal
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
}
