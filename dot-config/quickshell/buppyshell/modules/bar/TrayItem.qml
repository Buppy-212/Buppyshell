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
    scrollable: true
    function scrolled(event) {
        root.modelData.scroll(event.angleDelta.y, true);
    }
    function tapped(eventPoint, button): void {
        switch (button) {
        case Qt.LeftButton:
            root.modelData.activate();
            break;
        case Qt.MiddleButton:
            root.modelData.secondaryActivate();
            break;
        case Qt.RightButton:
            menu.open();
            break;
        }
    }
    QsMenuAnchor {
        id: menu
        menu: root.modelData.menu
        anchor {
            item: root
            edges: Theme.barOnRight ? Edges.Left | Edges.Top : Edges.Right | Edges.Top
            gravity: Theme.barOnRight ? Edges.Left | Edges.Bottom : Edges.Right | Edges.Bottom
        }
    }
}
