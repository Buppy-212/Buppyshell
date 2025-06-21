import Quickshell
import QtQuick
import Quickshell.Io
import "root:/services"
import "root:/widgets"

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
      height: 30 + Hyprland.workspaces.values[index].lastIpcObject.windows * 34
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
          Hyprland.dispatch(`workspace ${index+1}`)
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
          width: 32
          height: 32
          source: {
            if (modelData.workspace.id === workspaceCell.index +1) {
              visible = true
              if (wmClass.startsWith("steam_app")) {
                return Quickshell.iconPath("steam_app_0")
              } else {
                return Quickshell.iconPath(wmClass, symbolImgMap[wmClass] ?? wmClass.toLowerCase())
              }
            } else
            visible = false
            return Quickshell.iconPath("image-loading")
          }
          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked:{
              Hyprland.dispatch(`focuswindow address:${modelData.address}`)
            }
          }
        }
      }
    }
  }
  property var symbolImgMap: {
    "MuseScore4": "musescore",
    "via-nativia": "keyboard",
    "steam_app_0": "input-gaming",
    "StardewModdingAPI": "stardew-valley"
  }
}
