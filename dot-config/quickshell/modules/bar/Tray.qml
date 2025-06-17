import Quickshell.Services.SystemTray
import QtQuick
import "root:/widgets"

Item {
    id: root
    readonly property Repeater items: items
    clip: true
    visible: width > 0 && height > 0 // To avoid warnings about being visible with no size
    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight
    Row {
        id: layout
        spacing: 8
        Repeater {
            id: items
            model: SystemTray.items
            TrayItem {}
        }
    }
}
