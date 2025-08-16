import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import qs.services

Item {
    id: root
    required property PanelWindow bar
    clip: true
    visible: repeater.count > 0
    Column {
        id: column
        spacing: 2
        anchors.fill: parent
        Repeater {
            id: repeater
            model: SystemTray.items
            TrayItem {
                id: trayItem
                tray: root
                bar: root.bar
                implicitWidth: root.width
                implicitHeight: width * 0.8
            }
        }
    }
}
