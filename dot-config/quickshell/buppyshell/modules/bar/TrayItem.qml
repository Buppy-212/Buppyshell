pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import qs.services
import qs.widgets

StyledButton {
    id: root
    required property SystemTrayItem modelData
    required property PanelWindow bar
    required property Item tray
    contentItem: IconImage {
        id: icon
        anchors.fill: parent
        source: {
            let icon = root.modelData.icon;
            if (icon.includes("?path=")) {
                const [name, path] = icon.split("?path=");
                icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
            }
            return icon;
        }
    }
    function tapped(eventPoint, button): void {
        if (button === Qt.LeftButton) {
            root.modelData.activate();
        } else if (root.modelData.hasMenu) {
            menu.open();
        }
    }
    QsMenuAnchor {
        id: menu
        menu: root.modelData.menu
        anchor.window: root.bar
        anchor.rect.x: Theme.radius.normal
        anchor.rect.y: tray.y + root.y
        anchor.edges: Edges.Right
        anchor.gravity: Edges.Left | Edges.Bottom
    }
}
