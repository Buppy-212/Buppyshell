pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import qs.services
import qs.widgets

ScrollView {
    id: root
    ScrollBar.vertical.policy: ScrollBar.AlwaysOff
    Column {
        Repeater {
            model: Hyprland.workspaces
            delegate: StyledTabButton {
                id: workspace
                required property HyprlandWorkspace modelData
                implicitHeight: (toplevelRepeater.count + 1) * Theme.blockWidth
                implicitWidth: root.width
                dragged: dropArea.containsDrag
                borderSide: StyledTabButton.Right
                selected: modelData?.focused
                accentColor: Theme.color.accent
                function tapped(): void {
                    if (!workspace.modelData.focused) {
                        workspace.modelData.activate();
                    }
                }
                DropArea {
                    id: dropArea
                    anchors.fill: parent
                    onDropped: drop => {
                        if (drag.source.silent) {
                            Hyprland.dispatch(`movetoworkspacesilent ${workspace.modelData.id}, address:0x${drag.source.modelData.address}`);
                        } else {
                            Hyprland.dispatch(`movetoworkspace ${workspace.modelData.id}, address:0x${drag.source.modelData.address}`);
                        }
                    }
                }
                contentItem: Column {
                    id: column
                    anchors.fill: parent
                    spacing: 0
                    StyledText {
                        text: workspace.modelData.id === 10 ? 0 : workspace.modelData.id
                        width: column.width
                        height: Theme.blockWidth
                        color: workspace.buttonColor
                    }
                    Repeater {
                        id: toplevelRepeater
                        model: workspace.modelData.toplevels
                        delegate: IconImage {
                            id: toplevel
                            required property HyprlandToplevel modelData
                            property bool silent: true
                            width: column.width
                            height: Theme.blockWidth
                            implicitSize: height
                            Drag.active: mouseArea.drag.active
                            Drag.hotSpot: Qt.point(width / 2, height / 2)
                            source: {
                                if (modelData?.wayland?.appId.startsWith("steam_app")) {
                                    return Quickshell.iconPath("input-gaming");
                                } else {
                                    return Quickshell.iconPath(modelData?.wayland?.appId?.toLowerCase() ?? "image-loading", modelData?.wayland?.appId);
                                }
                            }
                            states: State {
                                when: mouseArea.drag.active
                                ParentChange {
                                    target: toplevel
                                    parent: root
                                }
                            }
                            MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                                drag.target: parent
                                drag.axis: Drag.YAxis
                                onClicked: mouse => {
                                    switch (mouse.button) {
                                    case Qt.LeftButton:
                                        Hyprland.dispatch(`focuswindow address:0x${toplevel.modelData.address}`);
                                        break;
                                    case Qt.MiddleButton:
                                        toplevel.modelData.wayland.close();
                                        break;
                                    case Qt.RightButton:
                                        Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedWorkspace.id}, address:0x${toplevel.modelData.address}`);
                                        break;
                                    }
                                }
                                onReleased: mouse => {
                                    if (mouse.button === Qt.RightButton) {
                                        parent.silent = false;
                                    } else {
                                        parent.silent = true;
                                    }
                                    parent.Drag.drop();
                                }
                            }
                            LazyLoader {
                                active: mouseArea.containsMouse && !mouseArea.drag.active
                                component: PopupWindow {
                                    anchor {
                                        item: toplevel
                                        edges: Theme.barOnRight ? Edges.Left : Edges.Right
                                        gravity: Theme.barOnRight ? Edges.Left : Edges.Right
                                    }
                                    implicitHeight: toplevel.height
                                    implicitWidth: title.implicitWidth
                                    visible: true
                                    color: "transparent"

                                    Rectangle {
                                        anchors.fill: parent
                                        radius: Theme.radius
                                        color: Theme.color.bg
                                        border.width: Theme.border
                                        border.color: Theme.color.grey

                                        StyledText {
                                            id: title

                                            padding: Theme.margin
                                            anchors.fill: parent
                                            text: toplevel.modelData.title
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
