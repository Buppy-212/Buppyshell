import Quickshell.Services.SystemTray
import QtQuick
import "root:/widgets"

Item {
    id: root
    readonly property Repeater items: items
    clip: true
    visible: width > 0 && height > 0
    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight
    Row {
        id: layout
        spacing: 4
        Repeater {
            id: items
            model: SystemTray.items
            TrayItem {}
        }
    }
}
