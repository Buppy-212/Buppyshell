import Quickshell
import Quickshell.Widgets
import QtQuick
import "root:/services"
import "root:/widgets"

Item {
  id: root
  width: 30
  height: column.height
  Column {
    id: column
    spacing: 4
    width: 30
    Repeater {
      model: Hyprland.workspaces
      Rectangle {
        id: workspaceCell
        anchors.horizontalCenter: parent.horizontalCenter
        required property int index
        property bool draggedOver: false
        property bool focused: Hyprland.focusedMonitor?.activeWorkspace.id === (index + 1)
        height: Hyprland.workspaces.values[index].lastIpcObject.windows * 32 + 30
        width: 26
        radius: Theme.rounding
        color: draggedOver ? Theme.color.gray : focused ? Theme.color.darkblue : Theme.color.black
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
        Column {
          width: 26
          Rectangle {
            implicitWidth: 26
            implicitHeight: 30
            radius: Theme.rounding
            color: "transparent"
            BarText {
              id: workspaceText
              text: index === 9 ? 0 : index + 1
            }
            MouseArea {
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
              implicitSize: 30
              Drag.active: mouseArea.drag.active
              Drag.hotSpot: Qt.point(15,15)
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
                onReleased: {
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

