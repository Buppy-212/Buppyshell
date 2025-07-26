pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import qs.services
import qs.widgets

Item {
    id: root
    Row {
        anchors.fill: parent
        Repeater {
            id: toplevelRepeater
            model: ToplevelManager.toplevels
            delegate: WrapperMouseArea {
                id: toplevel
                required property Toplevel modelData
                onClicked: {
                    Quickshell.execDetached(["hyprctl", "dispatch", "focuswindow", `address:0x${toplevel.modelData.HyprlandToplevel.handle.address}`]);
                    GlobalState.launcher = false;
                }
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                Rectangle {
                    id: workspaceId
                    implicitWidth: root.width / toplevelRepeater.count
                    implicitHeight: root.height
                    color: toplevel.containsMouse ? Theme.color.grey : toplevel.modelData?.activated ? Theme.color.bgalt : Theme.color.bg
                    Row {
                        anchors.fill: parent
                        IconImage {
                            implicitSize: root.height
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
                        Text {
                            height: parent.height
                            width: parent.width - root.height
                            text: toplevel.modelData?.title ?? ""
                            color: Theme.color.fg
                            font {
                                family: Theme.font.family.mono
                                pointSize: Theme.font.size.normal
                                bold: true
                            }
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Rectangle {
                        anchors.bottom: parent.bottom
                        implicitWidth: parent.width
                        implicitHeight: Theme.border
                        color: toplevel.modelData?.activated ? Theme.color.accent : Theme.color.bg
                    }
                }
            }
        }
    }
}
