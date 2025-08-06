pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

Rectangle {
    color: Theme.color.bg
    visible: ToplevelManager.toplevels.values.length > 0
    RowLayout {
        anchors.fill: parent
        uniformCellSizes: true
        spacing: 0
        Repeater {
            model: ToplevelManager.toplevels
            delegate: StyledTabButton {
                id: toplevel
                required property Toplevel modelData
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: hovered ? Theme.color.accent : Theme.color.fg
                selected: modelData?.activated
                contentItem: RowLayout {
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
                        text: toplevel.modelData?.title ?? ""
                        color: toplevel.color
                        horizontalAlignment: Text.AlignLeft
                        elide: Text.ElideRight
                    }
                }
                function tapped(pointEvent, button) {
                    switch (button) {
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
            }
        }
    }
}
