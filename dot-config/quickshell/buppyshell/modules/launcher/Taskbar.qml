pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

Item {
    RowLayout {
        anchors.fill: parent
        uniformCellSizes: true
        spacing: 0
        Repeater {
            model: ToplevelManager.toplevels
            delegate: MouseArea {
                id: toplevel
                required property Toplevel modelData
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor
                onClicked: mouse => {
                    switch (mouse.button) {
                    case Qt.LeftButton:
                        Quickshell.execDetached(["hyprctl", "dispatch", "focuswindow", `address:0x${toplevel.modelData.HyprlandToplevel.handle.address}`]);
                        GlobalState.launcher = false;
                        break;
                    case Qt.MiddleButton:
                        modelData.close();
                        break;
                    case Qt.RightButton:
                        Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedWorkspace.id}, address:0x${modelData.HyprlandToplevel.handle.address}`);
                        GlobalState.launcher = false;
                        break;
                    }
                }
                Layout.fillHeight: true
                Layout.fillWidth: true
                Rectangle {
                    anchors.fill: parent
                    color: toplevel.containsMouse ? Theme.color.grey : toplevel.modelData?.activated ? Theme.color.bgalt : Theme.color.bg
                    RowLayout {
                        anchors.fill: parent
                        IconImage {
                            Layout.fillHeight: true
                            Layout.preferredWidth: height
                            source: {
                                if (toplevel.modelData?.appId.startsWith("steam_app")) {
                                    return Quickshell.iconPath("input-gaming");
                                } else if (toplevel.modelData?.appId == "") {
                                    return (Quickshell.iconPath("image-loading"));
                                } else {
                                    return Quickshell.iconPath(toplevel.modelData?.appId.toLowerCase() ?? "image-loading", toplevel.modelData?.appId);
                                }
                            }
                        }
                        StyledText {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            anchors.fill: undefined
                            text: toplevel.modelData?.title ?? ""
                            color: toplevel.containsMouse ? Theme.color.accent : Theme.color.fg
                            horizontalAlignment: Text.AlignLeft
                            elide: Text.ElideRight
                        }
                    }
                    Rectangle {
                        anchors {
                            fill: parent
                            topMargin: parent.height * 0.96
                        }
                        color: toplevel.modelData?.activated ? Theme.color.accent : Theme.color.bg
                    }
                }
            }
        }
    }
}
