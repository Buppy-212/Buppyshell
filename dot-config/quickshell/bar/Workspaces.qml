import Quickshell
import Quickshell.Widgets
import QtQuick
import "root:/services"

Item {
  id: root
  width: Theme.blockWidth
  height: column.height
  Column {
    id: column
    spacing: Theme.border*2
    width: Theme.blockWidth
    Repeater {
      model: Hyprland.workspaces
      Rectangle {
        id: workspaceCell
        anchors.horizontalCenter: parent.horizontalCenter
        required property int index
        property bool draggedOver: false
        property bool occupied: Hyprland.workspaces.values[index]?.lastIpcObject.windows > 0
        property bool focused: Hyprland.focusedMonitor?.activeWorkspace.id === (index + 1)
        height: occupied ? (Hyprland.workspaces.values[index].lastIpcObject.windows + 1) * (Theme.blockWidth - Theme.border) : Theme.blockWidth - Theme.border
        width: Theme.blockWidth - Theme.border
        radius: Theme.rounding
        color: draggedOver | mouse.containsMouse ? Theme.color.gray : focused ? Theme.color.accent : occupied ? Theme.color.bgalt : "transparent"
        DropArea {
          anchors.fill: parent
          onEntered: (drag) => { 
            drag.source.caught = true;
            draggedOver = true
          }
          onExited: { 
            drag.source.caught = false 
            draggedOver = false
          }
          onDropped: (drop) => {
            draggedOver = false
            if (drag.source.silent) {
              Hyprland.dispatch(`movetoworkspacesilent ${index+1}, address:0x${drag.source.address}`)
            } else {
              Hyprland.dispatch(`movetoworkspace ${index+1}, address:0x${drag.source.address}`)
            }
          }
        }
        Behavior on color {
          animation: Theme.animation.elementMove.colorAnimation.createObject(this)
        } 
        Behavior on height {
              animation: Theme.animation.elementMove.numberAnimation.createObject(this)
        }
        Column {
          width: Theme.blockWidth - Theme.border
          Rectangle {
            implicitWidth: Theme.blockWidth - Theme.border
            implicitHeight: Theme.blockWidth - Theme.border
            radius: Theme.rounding
            color: "transparent"
            StyledText {
              id: workspaceText
              text: index === 9 ? 0 : index + 1
            }
            MouseArea {
              id: mouse
              anchors.fill: parent
              acceptedButtons: Qt.LeftButton
              cursorShape: Qt.PointingHandCursor
              hoverEnabled: true
              onClicked: Hyprland.workspaces.values[index].activate()
            }
          }
          Repeater {
            model: Hyprland.toplevels
            IconImage {
              id: image
              anchors.horizontalCenter: parent.horizontalCenter
              property point beginDrag
              property bool silent: true
              property string address: modelData.address
              property bool caught: false
              implicitSize: Theme.blockWidth - Theme.border
              Drag.active: mouseArea.drag.active
              Drag.hotSpot: Qt.point(implicitSize/2,implicitSize/2)
              source: {
                if (modelData.workspace?.id === workspaceCell.index + 1) {
                  visible = true;
                  if (modelData.wayland?.appId.startsWith("steam_app")) {
                    return Quickshell.iconPath("input-gaming");
                  } else {
                    return Quickshell.iconPath(modelData.wayland?.appId.toLowerCase() ?? "image-loading", modelData.wayland?.appId);
                  }
                } else {
                  visible = false;
                  return "";
                }
              }
              states: State {
                when: mouseArea.drag.active
                ParentChange { target: image; parent: column }
              }
              MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                drag.target: parent
                onEntered: {
                  Hyprland.overrideTitle(modelData.title)
                }
                onExited: {
                  Hyprland.refreshTitle()
                }
                onClicked: (mouse) => {
                  if (mouse.button == Qt.LeftButton) {
                    Hyprland.dispatch(`focuswindow address:0x${address}`)
                  } else if (mouse.button == Qt.MiddleButton) {
                    modelData.wayland.close()
                  } else {
                    Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedMonitor?.activeWorkspace.id}, address:0x${address}`)
                  }
                }
                onPressed: {
                  image.beginDrag = Qt.point(image.x, image.y);
                }
                onReleased: (mouse) => {
                  if (mouse.button == Qt.RightButton) {
                    parent.silent = false
                  } else {
                    parent.silent = true
                  }
                  parent.Drag.drop()

                }
              }
            }
          }
        }
      }
    }
  }
}
