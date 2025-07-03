pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "root:/services"

Block {
  id: root
  width: Theme.blockWidth - 2
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
      if (modelData.title) {
        Hyprland.overrideTitle(modelData.title)
      } else {
        Hyprland.overrideTitle(modelData.tooltipTitle)
      }
    }
    QsMenuAnchor {
      id: menu
      menu: root.modelData.menu
      anchor.window: bar
      anchor.rect.x: bar.width - layout.width + root.x
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
