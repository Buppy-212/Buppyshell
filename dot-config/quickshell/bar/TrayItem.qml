pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../services"

Block {
    id: trayItem
    required property SystemTrayItem modelData
    width: Theme.blockWidth - 2
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
        onEntered: {
            if (trayItem.modelData.title) {
                HyprHyprTitle.overrideTitle(trayItem.modelData.title);
            } else {
                HyprHyprTitle.overrideTitle(trayItem.modelData.tooltipTitle);
            }
        }
        onExited: HyprTitle.refreshTitle()
        QsMenuAnchor {
            id: menu
            menu: trayItem.modelData.menu
            anchor.window: rightBar
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
