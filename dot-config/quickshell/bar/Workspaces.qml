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
        height: occupied ? (modelData.toplevels.values.length + 1) * (width + 2) : 28
        width: Theme.blockWidth
        radius: Theme.rounding
        color: draggedOver | mouse.containsMouse ? Theme.color.grey : focused ? Theme.color.accent : occupied ? Theme.color.bgalt : "transparent"
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
          spacing: 2
          width: workspaceCell.width
          anchors.fill: parent
          Rectangle {
            implicitWidth: workspaceCell.width
            implicitHeight: workspaceCell.width
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
              implicitSize: workspaceCell.width
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
                onEntered: Hyprland.overrideTitle(modelData.title)
                onExited: Hyprland.refreshTitle()
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
