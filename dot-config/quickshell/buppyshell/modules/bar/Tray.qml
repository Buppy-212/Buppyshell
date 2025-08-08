import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import qs.services

Item {
    id: root
    required property PanelWindow bar
    clip: true
    visible: width > 0 && height > 0
    implicitHeight: column.implicitHeight
    implicitWidth: Theme.width.block
    Column {
        id: column
        spacing: Theme.margin.tiny
        anchors.centerIn: parent
        Repeater {
            id: repeater
            model: SystemTray.items
            TrayItem {
                id: trayItem
                tray: root
                bar: root.bar
            }
        }
    }
}
