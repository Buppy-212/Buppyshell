import Quickshell.Services.SystemTray
import QtQuick
import "../services"

Item {
    id: trayRoot
    readonly property Repeater items: items
    clip: true
    visible: width > 0 && height > 0
    implicitHeight: layout.implicitHeight
    implicitWidth: Theme.blockWidth
    Column {
        id: layout
        anchors.centerIn: parent
        Repeater {
            id: items
            model: SystemTray.items
            TrayItem {}
        }
    }
}
