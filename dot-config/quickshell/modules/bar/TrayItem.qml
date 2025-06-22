pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import "root:/windows"

MouseArea {
  id: root
  cursorShape: root.disabled ? undefined : Qt.PointingHandCursor
  hoverEnabled: true
  required property SystemTrayItem modelData
  acceptedButtons: Qt.LeftButton | Qt.RightButton
  implicitWidth: icon.width
  implicitHeight: icon.height
  onClicked: event => {
    if (event.button === Qt.LeftButton) {
      modelData.activate();
    } else if (modelData.hasMenu) {
      menu.open();
    }
  }
    QsMenuAnchor {
        id: menu
        menu: root.modelData.menu
        anchor.window: bar
        anchor.rect.x: root.x + bar.width
        anchor.rect.y: root.y
        anchor.rect.height: root.height
        anchor.edges: Edges.Bottom
    }
  IconImage {
    id: icon
    source: {
      let icon = root.modelData.icon;
      if (icon.includes("?path=")) {
        const [name, path] = icon.split("?path=");
        icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
      }
      return icon;
    }
    implicitSize: 24
  }
}
