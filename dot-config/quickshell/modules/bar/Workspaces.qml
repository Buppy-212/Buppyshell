import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "root:/services"
import "root:/widgets"

ColumnLayout {
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
          height: image.height
          model: Hyprland.clients
          Image {
            id: image
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
            width: 32
            height: 32
            source: {
              if (modelData.workspace.id === workspaceCell.index +1) {
                visible = true
                return Quickshell.iconPath(modelData.wmClass, symbolImgMap[modelData.wmClass] ?? modelData.wmClass.toLowerCase())
              } else
              visible = false
              return Quickshell.iconPath("image-loading")
            }
          }
        }
      }
    }
  }
  property var symbolImgMap: {
    "MuseScore4": "musescore",
    "via-nativia": "keyboard",
  }
}
