pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import "../services"
import "../widgets"

Item {
    id: root
    height: parent.height
    width: row.width
    Row {
        id: row
        spacing: 4
        height: parent.height
        Repeater {
            model: Hyprland.workspaces
            delegate: Rectangle {
                id: workspaceCell
                required property HyprlandWorkspace modelData
                property bool draggedOver: false
                property bool occupied: modelData.toplevels.values.length
                property bool focused: modelData.focused
                anchors.verticalCenter: parent.verticalCenter
                width: occupied ? (modelData.toplevels.values.length + 1) * 24 : 24
                height: parent.height - 2
                radius: Theme.rounding
                color: draggedOver | mouse.containsMouse ? Theme.color.grey : focused ? Theme.color.accent : occupied ? Theme.color.bgalt : "transparent"
                DropArea {
                    anchors.fill: parent
                    onEntered: drag => {
                        drag.source.caught = true;
                        workspaceCell.draggedOver = true;
                    }
                    onExited: {
                        drag.source.caught = false;
                        workspaceCell.draggedOver = false;
                    }
                    onDropped: drop => {
                        workspaceCell.draggedOver = false;
                        if (drag.source.silent) {
                            Hyprland.dispatch(`movetoworkspacesilent ${workspaceCell.modelData.id}, address:0x${drag.source.modelData.address}`);
                        } else {
                            Hyprland.dispatch(`movetoworkspace ${workspaceCell.modelData.id}, address:0x${drag.source.modelData.address}`);
                        }
                    }
                }
                Behavior on color {
                    animation: Theme.animation.elementMove.colorAnimation.createObject(this)
                }
                Behavior on height {
                    animation: Theme.animation.elementMove.numberAnimation.createObject(this)
                }
                Row {
                    spacing: 2
                    width: workspaceCell.width
                    anchors.fill: parent
                    Rectangle {
                        implicitWidth: workspaceCell.height
                        implicitHeight: workspaceCell.height
                        anchors.verticalCenter: parent.verticalCenter
                        radius: Theme.rounding
                        color: "transparent"
                        StyledText {
                            id: workspaceText
                            text: workspaceCell.modelData.id === 10 ? 0 : workspaceCell.modelData.id
                        }
                        MouseBlock {
                            id: mouse
                            onClicked: if (!workspaceCell.focused) {
                                workspaceCell.modelData.activate();
                            }
                        }
                    }
                    Repeater {
                        id: toplevelRepeater
                        height: parent.height
                        model: workspaceCell.modelData.toplevels
                        delegate: IconImage {
                            id: image
                            required property HyprlandToplevel modelData
                            property bool silent: true
                            property bool caught: false
                            anchors.verticalCenter: toplevelRepeater.verticalCenter
                            implicitSize: workspaceCell.height
                            Drag.active: mouseArea.drag.active
                            Drag.hotSpot: Qt.point(implicitSize / 2, implicitSize / 2)
                            source: {
                                if (modelData?.wayland?.appId.startsWith("steam_app")) {
                                    return Quickshell.iconPath("input-gaming");
                                } else if (modelData?.wayland?.appId == "") {
                                    return (Quickshell.iconPath("image-loading"));
                                } else {
                                    return Quickshell.iconPath(modelData?.wayland?.appId.toLowerCase() ?? "image-loading", modelData?.wayland?.appId);
                                }
                            }
                            states: State {
                                when: mouseArea.drag.active
                                ParentChange {
                                    target: image
                                    parent: dragArea
                                }
                            }
                            MouseBlock {
                                id: mouseArea
                                drag.target: parent
                                drag.axis: Drag.XAxis
                                onEntered: GlobalState.overrideTitle(modelData.title)
                                onExited: GlobalState.refreshTitle()
                                onClicked: mouse => {
                                    if (mouse.button == Qt.LeftButton) {
                                        Hyprland.dispatch(`focuswindow address:0x${image.modelData.address}`);
                                    } else if (mouse.button == Qt.MiddleButton) {
                                        image.modelData.wayland.close();
                                    } else {
                                        Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedWorkspace.id}, address:0x${image.modelData.address}`);
                                    }
                                }
                                onReleased: mouse => {
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
