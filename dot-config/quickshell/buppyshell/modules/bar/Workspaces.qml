pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

ColumnLayout {
    id: root
    required property PanelWindow bar
    spacing: 0
    Repeater {
        model: Hyprland.workspaces
        delegate: StyledTabButton {
            id: workspace
            required property HyprlandWorkspace modelData
            Layout.preferredHeight: (toplevelRepeater.count + 1) * width
            Layout.fillWidth: true
            dragged: dropArea.containsDrag
            borderSide: StyledTabButton.BorderSide.Left
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
                    height: width
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
                        height: width
                        implicitSize: width
                        Drag.active: mouseArea.drag.active
                        Drag.hotSpot: Qt.point(width / 2, height / 2)
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
                                target: toplevel
                                parent: dragArea
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
                                if (mouse.button == Qt.LeftButton) {
                                    Hyprland.dispatch(`focuswindow address:0x${toplevel.modelData.address}`);
                                } else if (mouse.button == Qt.MiddleButton) {
                                    toplevel.modelData.wayland.close();
                                } else {
                                    Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedWorkspace.id}, address:0x${toplevel.modelData.address}`);
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
                            asynchronous: true
                            sourceComponent: PopupWindow {
                                anchor {
                                    window: root.bar
                                    rect.x: root.parent.width + Theme.margin.tiny
                                    rect.y: toplevel.parent == dragArea ? toplevel.y + dragArea.y + root.y : root.y + workspace.y + toplevel.y
                                }
                                implicitHeight: toplevel.height
                                implicitWidth: title.contentWidth + Theme.margin.large
                                color: "transparent"
                                Rectangle {
                                    anchors.fill: parent
                                    radius: Theme.radius.normal
                                    color: Theme.color.bg
                                    border.width: Theme.border
                                    border.color: Theme.color.grey
                                    StyledText {
                                        id: title
                                        anchors.fill: parent
                                        text: toplevel.modelData.title
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
    Item {
        id: dragArea
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
