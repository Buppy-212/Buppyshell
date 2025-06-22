import Quickshell
import QtQuick
import Quickshell.Io
import "root:/services"
import "root:/widgets"
import "root:/modules/bar"

Column {
  spacing: 4
  Repeater {
    model: Hyprland.workspaces
    Column {
      spacing: 2
      id: workspaceCell
      required property int index
      property bool focused: Hyprland.activeWsId === (index + 1)
      property var clientIndex: Hyprland.workspaces.values[index].id
      height: 30 + Hyprland.workspaces.values[index].lastIpcObject.windows * 32
      width: 26
      BarBlock {
        implicitWidth: 26
        implicitHeight: 30
        radius: Theme.rounding
        color: focused === true ? Theme.color.yellow : "transparent"
        BarText {
          id: workspaceText
          text: index === 9 ? 0 : (index + 1).toString()
          color: focused === true ? Theme.color.black : Theme.color.fg
        }
        function onClicked(): void {
          Hyprland.dispatch(`workspace ${index+1}`);
        }
      }
      Repeater {
        id: repeater
        model: Hyprland.clients
        Image {
          id: image
          property string wmClass: modelData.wmClass
          anchors.horizontalCenter: parent.horizontalCenter
          visible: false
          width: 30
          height: 30
          source: {
            if (modelData.workspace.id === workspaceCell.index + 1) {
              visible = true;
              if (wmClass.startsWith("steam_app")) {
                return Quickshell.iconPath("input-gaming");
              } else {
                return Quickshell.iconPath(symbolImgMap[wmClass] ?? wmClass, wmClass.toLowerCase());
              }
            } else {
              visible = false;
              return Quickshell.iconPath("image-loading");
            }
          }
          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: {
              Hyprland.overrideTitle(modelData.title)
            }
            onExited: {
              Hyprland.overrideTitle(Hyprland.activeClient.title)
            }
            onClicked:{
              Hyprland.dispatch(`focuswindow address:${modelData.address}`);
            }
          }
        }
      }
    }
  }
  property var symbolImgMap: {
    "zen": "zen-browser",
    "StardewModdingAPI": "stardew-valley",
    "": "image-loading"
  }
}
