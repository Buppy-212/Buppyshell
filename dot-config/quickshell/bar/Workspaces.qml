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
    spacing: 4
    width: Theme.blockWidth
    Repeater {
      model: Hyprland.workspaces
      Rectangle {
        id: workspaceCell
        anchors.horizontalCenter: parent.horizontalCenter
        property bool draggedOver: false
        property bool occupied: modelData.toplevels.values.length > 0
        property bool focused: modelData.focused
        height: modelData.toplevels.values.length * (Theme.blockWidth - 4) + Theme.blockWidth
        width: Theme.blockWidth - 2
        radius: Theme.rounding
        color: draggedOver | mouse.containsMouse ? Theme.color.gray : focused ? Theme.color.accent : occupied ? Theme.color.bgalt : "transparent"
        MouseBlock {
          onEntered: {
            Hyprland.refreshTitle();
          }
        }
        DropArea {
          anchors.fill: parent
          onEntered: (drag) => { 
            drag.source.caught = true;
            draggedOver = true;
          }
          onExited: { 
            drag.source.caught = false;
            draggedOver = false;
          }
          onDropped: (drop) => {
            draggedOver = false;
            if (drag.source.silent) {
              Hyprland.dispatch(`movetoworkspacesilent ${modelData.id}, address:0x${drag.source.address}`);
            } else {
              Hyprland.dispatch(`movetoworkspace ${modelData.id}, address:0x${drag.source.address}`);
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
          width: workspaceCell.width
          anchors.margins: 2
          anchors.fill: parent
          Rectangle {
            implicitWidth: workspaceCell.width - 4
            implicitHeight: workspaceCell.width - 2
            anchors.horizontalCenter: parent.horizontalCenter
            radius: Theme.rounding
            color: "transparent"
            StyledText {
              id: workspaceText
              text: modelData.id === 10 ? 0 : modelData.id
            }
            MouseBlock {
              id: mouse
              onClicked: if (!focused) { modelData.activate(); }
              onEntered: Hyprland.overrideTitle(`Workspace ${modelData.id}`);
            }
          }
          Repeater {
            model: modelData.toplevels
            IconImage {
              id: image
              anchors.horizontalCenter: parent.horizontalCenter
              property bool silent: true
              property string address: modelData.address
              property bool caught: false
              implicitSize: workspaceCell.width - 2
              Drag.active: mouseArea.drag.active
              Drag.hotSpot: Qt.point(implicitSize/2,implicitSize/2)
              source: {
                if (modelData.wayland?.appId.startsWith("steam_app")) {
                  return Quickshell.iconPath("input-gaming");
                } else if (modelData.wayland?.appId == ""){
                  return (Quickshell.iconpath("image-loading"))
                } else {
                  return Quickshell.iconPath(modelData.wayland?.appId.toLowerCase() ?? "image-loading", modelData.wayland?.appId);
                }
              }
              states: State {
                when: mouseArea.drag.active
                ParentChange { target: image; parent: dragArea }
              }
              MouseBlock {
                id: mouseArea
                drag.target: parent
                onEntered: {
                  Hyprland.overrideTitle(modelData.title);
                }
                onClicked: (mouse) => {
                  if (mouse.button == Qt.LeftButton) {
                    Hyprland.dispatch(`focuswindow address:0x${address}`);
                  } else if (mouse.button == Qt.MiddleButton) {
                    modelData.wayland.close();
                  } else {
                    Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedWorkspace.id}, address:0x${address}`);
                  }
                }
                onReleased: (mouse) => {
                  if (mouse.button == Qt.RightButton) {
                    parent.silent = false;
                  } else {
                    parent.silent = true;
                  }
                  parent.Drag.drop();
                }
              }
            }
          }
        }
      }
    }
  }
  Item {
    id: dragArea
    anchors.centerIn: parent
  }
}
