pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import "root:/services"

Rectangle {
  id: root
  required property SystemTrayItem modelData
  implicitWidth: 30
  implicitHeight: 24
  color: mouse.containsMouse ? Theme.color.gray : "transparent"
  radius: Theme.rounding
  MouseArea {
    id: mouse
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    anchors.fill: parent
    onClicked: (mouse) => {
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
      anchors.centerIn: parent
      implicitSize: 24
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
