pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../../services"
import "../../widgets"

Block {
    id: trayItem
    required property SystemTrayItem modelData
    hovered: mouse.containsMouse
    MouseBlock {
        id: mouse
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                trayItem.modelData.activate();
            } else if (trayItem.modelData.hasMenu) {
                menu.open();
            }
        }
        QsMenuAnchor {
            id: menu
            menu: trayItem.modelData.menu
            anchor.window: rightBar
            anchor.rect.x: Theme.rounding
            anchor.rect.y: trayRoot.y + trayItem.y
            anchor.edges: Edges.Right
            anchor.gravity: Edges.Left | Edges.Bottom
        }
        IconImage {
            id: icon
            anchors.centerIn: parent
            implicitSize: Theme.blockHeight
            source: {
                let icon = trayItem.modelData.icon;
                if (icon.includes("?path=")) {
                    const [name, path] = icon.split("?path=");
                    icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
                }
                return icon;
            }
        }
    }
}
