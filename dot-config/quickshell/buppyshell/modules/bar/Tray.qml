import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Controls
import qs.services

ScrollView {
    id: root
    ScrollBar.vertical.policy: ScrollBar.AlwaysOff
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
                implicitWidth: root.width
                implicitHeight: Theme.blockWidth
            }
        }
    }
}
