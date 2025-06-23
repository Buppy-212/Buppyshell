import Quickshell
import Quickshell.Widgets
import QtQuick
import "root:/services"
import "root:/widgets"
import "root:/modules/bar"

Column {
  spacing: 4
  Repeater {
    model: Hyprland.workspaces
    Column {
      spacing: 1
      id: workspaceCell
      required property int index
      property bool focused: Hyprland.focusedMonitor?.activeWorkspace.id === (index + 1)
      height: (Hyprland.workspaces.values[index].lastIpcObject.windows + 1) * 30
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
          Hyprland.workspaces.values[index].activate()
        }
        Behavior on color {
          animation: Theme.animation.elementMoveFast.colorAnimation.createObject(this)
        }
      }
      Repeater {
        id: repeater
        model: Hyprland.toplevels
        IconImage {
          id: image
          anchors.horizontalCenter: parent.horizontalCenter
          visible: true
          implicitSize: 30
          source: {
            if (modelData.workspace?.id === workspaceCell.index + 1) {
              visible = true;
              if (modelData.wayland?.appId.startsWith("steam_app")) {
                return Quickshell.iconPath("input-gaming");
              } else {
                return Quickshell.iconPath(modelData.wayland?.appId ?? "image-loading", modelData.wayland?.appId.toLowerCase());
              }
            } else {
              visible = false;
              return "";
            }
          }
          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton
            onEntered: {
              Hyprland.overrideTitle(modelData.title)
            }
            onExited: {
              Hyprland.refreshTitle()
            }
            onClicked: (mouse) => {
              if (mouse.button == Qt.LeftButton) {
                Hyprland.dispatch(`focuswindow address:0x${modelData.address}`)
              } else {
                modelData.wayland.close()
              }
            }
          }
        }
      }
      Behavior on height {
        animation: Theme.animation.elementMoveEnter.numberAnimation.createObject(this)
      }
    }
  }
}
