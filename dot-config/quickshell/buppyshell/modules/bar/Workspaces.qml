pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import "../../services"
import "../../widgets"

Item {
    id: root
    width: Theme.width.block
    height: column.height
    Column {
        id: column
        spacing: 4
        width: Theme.width.block
        Repeater {
            model: Hyprland.workspaces
            delegate: Rectangle {
                id: workspaceCell
                required property HyprlandWorkspace modelData
                property bool draggedOver: false
                property bool occupied: modelData.toplevels.values.length
                property bool focused: modelData.focused
                anchors.horizontalCenter: parent.horizontalCenter
                height: occupied ? (modelData.toplevels.values.length + 1) * (width + 2) : 28
                width: Theme.width.block
                radius: Theme.radius.normal
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
                Column {
                    spacing: 2
                    width: workspaceCell.width
                    anchors.fill: parent
                    Rectangle {
                        implicitWidth: workspaceCell.width
                        implicitHeight: workspaceCell.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        radius: Theme.radius.normal
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
                        width: parent.width
                        model: workspaceCell.modelData.toplevels
                        delegate: IconImage {
                            id: image
                            required property HyprlandToplevel modelData
                            property bool silent: true
                            property bool caught: false
                            anchors.horizontalCenter: toplevelRepeater.horizontalCenter
                            implicitSize: Theme.iconSize.small
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
                                drag.axis: Drag.YAxis
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
                            Loader {
                                active: mouseArea.containsMouse
                                sourceComponent: PopupWindow {
                                    anchor {
                                        window: leftBar
                                        rect.x: leftRect.width + Theme.margin.tiny
                                        rect.y: parent == dragArea ? image.y + dragArea.y + root.y : root.y + workspaceCell.y + image.y
                                    }
                                    implicitHeight: image.height
                                    implicitWidth: title.width + 12
                                    color: "transparent"
                                    Rectangle {
                                        anchors.fill: parent
                                        radius: Theme.radius.normal
                                        color: Theme.color.bg
                                        border.width: Theme.border
                                        border.color: Theme.color.grey
                                        StyledText {
                                            id: title
                                            text: image.modelData.title
                                        }
                                    }
                                    visible: true
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
