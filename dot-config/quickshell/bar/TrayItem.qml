pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "root:/services"

Block {
  id: root
  height: Theme.blockHeight - 2
  required property SystemTrayItem modelData
  MouseBlock {
    id: mouse
    onClicked: (mouse) => {
      if (mouse.button === Qt.LeftButton) {
        modelData.activate();
      } else if (modelData.hasMenu) {
        menu.open();
      }
    }
    onEntered: {
      if (modelData.tooltipTitle) {
        Hyprland.overrideTitle(modelData.tooltipTitle)
      } else {
        Hyprland.overrideTitle(modelData.title)
      }
    }
    QsMenuAnchor {
      id: menu
      menu: root.modelData.menu
      anchor.window: bar
      anchor.rect.x: root.x
      anchor.rect.y: root.y
      anchor.rect.height: root.height
      anchor.edges: Edges.Bottom
    }
    IconImage {
      id: icon
      anchors.centerIn: parent
      implicitSize: Theme.blockHeight
      source: {
        let icon = root.modelData.icon;
        if (icon.includes("?path=")) {
          const [name, path] = icon.split("?path=");
          icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
        }
        return icon;
      }
    }
  }
}
