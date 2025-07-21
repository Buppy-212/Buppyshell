pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../../services"

Item {
    anchors.fill: parent
    Keys.onEscapePressed: GlobalState.overlay = false
    Repeater {
        id: rep
        model: ToplevelManager.toplevels
        delegate: WrapperMouseArea {
            id: miniWindow
            required property int index
            required property Toplevel modelData
            x: parent.width / 2 - Screen.height / 3 * Math.cos(2 * Math.PI * index / rep.count) - width / 2
            y: parent.height / 2 - Screen.height / 3 * Math.sin(2 * Math.PI * index / rep.count) - height / 2
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            focus: modelData.activated
            focusPolicy: Qt.StrongFocus
            Keys.onReturnPressed: {
                Hyprland.dispatch(`focuswindow address:0x${modelData.HyprlandToplevel.handle.address}`);
                GlobalState.overlay = false;
            }
            Keys.onDeletePressed: modelData.close()
            onEntered: focus = true
            onClicked: mouse => {
                switch (mouse.button) {
                case Qt.LeftButton:
                    GlobalState.overlay = false;
                    Hyprland.dispatch(`focuswindow address:0x${modelData.HyprlandToplevel.handle.address}`);
                    break;
                case Qt.MiddleButton:
                    modelData.close();
                    break;
                case Qt.RightButton:
                    GlobalState.overlay = false;
                    Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedWorkspace.id}, address:0x${modelData.HyprlandToplevel.handle.address}`);
                    break;
                }
            }
            Behavior on x {
                animation: Theme.animation.elementMoveEnter.numberAnimation.createObject(this)
            }
            Behavior on y {
                animation: Theme.animation.elementMoveEnter.numberAnimation.createObject(this)
            }
            Rectangle {
                id: rect
                implicitWidth: rep.count < 4 ? Screen.width / 4 : Screen.width / rep.count
                implicitHeight: rep.count < 4 ? Screen.height / 4 + Theme.blockHeight : Screen.height / rep.count + Theme.blockHeight
                color: Theme.color.bgdark
                Column {
                    anchors.fill: parent
                    Rectangle {
                        width: parent.width
                        height: Theme.blockHeight
                        color: miniWindow.focus ? Theme.color.accent : Theme.color.black
                        RowLayout {
                            anchors.fill: parent
                            spacing: 2
                            anchors.rightMargin: 2
                            Text {
                                text: miniWindow.modelData.title
                                Layout.preferredWidth: parent.width - parent.height
                                Layout.preferredHeight: parent.height
                                color: Theme.color.fg
                                font {
                                    family: Theme.font.family.mono
                                    pointSize: Theme.font.size.normal
                                    bold: true
                                }
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideRight
                                maximumLineCount: 1
                            }
                            WrapperMouseArea {
                                Layout.preferredWidth: height
                                Layout.preferredHeight: parent.height
                                cursorShape: Qt.PointingHandCursor
                                onClicked: miniWindow.modelData.close()
                                Text {
                                    text: "close"
                                    color: Theme.color.red
                                    font {
                                        family: Theme.font.family.material
                                        pointSize: Theme.font.size.large
                                        bold: true
                                    }
                                    horizontalAlignment: Text.AlignRight
                                }
                            }
                        }
                    }
                    Loader {
                        active: visible
                        visible: miniWindow.focus
                        width: parent.width
                        height: parent.height - Theme.blockHeight
                        sourceComponent: ScreencopyView {
                            anchors.fill: parent
                            captureSource: miniWindow.modelData
                        }
                    }
                    IconImage {
                        visible: !miniWindow.focus
                        implicitWidth: parent.width
                        implicitHeight: parent.height - Theme.blockHeight
                        implicitSize: parent.height
                        source: {
                            if (miniWindow.modelData.appId.startsWith("steam_app")) {
                                return Quickshell.iconPath("input-gaming");
                            } else if (miniWindow.modelData.appId == "") {
                                return (Quickshell.iconPath("image-loading"));
                            } else {
                                return Quickshell.iconPath(miniWindow.modelData.appId.toLowerCase() ?? "image-loading", miniWindow.modelData.appId);
                            }
                        }
                    }
                }
            }
        }
    }
}
