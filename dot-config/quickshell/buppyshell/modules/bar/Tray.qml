import Quickshell.Services.SystemTray
import QtQuick
import qs.services

Item {
    id: trayRoot
    readonly property Repeater items: items
    clip: true
    visible: width > 0 && height > 0
    implicitHeight: layout.implicitHeight
    implicitWidth: Theme.width.block
    Column {
        id: layout
        spacing: Theme.margin.tiny
        anchors.centerIn: parent
        Repeater {
            id: items
            model: SystemTray.items
            TrayItem {}
        }
    }
}
