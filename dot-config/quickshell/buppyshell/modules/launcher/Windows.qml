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
        model: Hyprland.toplevels
        delegate: WrapperMouseArea {
            id: miniWindow
            required property int index
            required property HyprlandToplevel modelData
            x: parent.width / 2 - Screen.height / 3 * Math.cos(2 * Math.PI * index / rep.count) - width / 2
            y: parent.height / 2 - Screen.height / 3 * Math.sin(2 * Math.PI * index / rep.count) - height / 2
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            focus: modelData.activated
            focusPolicy: Qt.StrongFocus
            Keys.onReturnPressed: {
                Hyprland.dispatch(`focuswindow address:0x${modelData.address}`);
                GlobalState.overlay = false;
            }
            Keys.onDeletePressed: modelData.wayland.close()
            onEntered: focus = true
            onClicked: mouse => {
                switch (mouse.button) {
                case Qt.LeftButton:
                    GlobalState.overlay = false
                    Hyprland.dispatch(`focuswindow address:0x${modelData.address}`);
                    break;
                case Qt.MiddleButton:
                    modelData.wayland.close();
                    break;
                case Qt.RightButton:
                    GlobalState.overlay = false
                    Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedWorkspace.id}, address:0x${modelData.address}`);
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
                implicitHeight: rep.count < 4 ? Screen.height / 4 : Screen.height / rep.count + Theme.blockHeight
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
                                onClicked: miniWindow.modelData.wayland.close()
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
                        width: rect.width
                        height: rect.height - Theme.blockHeight
                        sourceComponent: miniWindow.focus || miniWindow.containsMouse ? preview : icon
                    }
                    Component {
                        id: icon
                        IconImage {
                            visible: !miniWindow.focus
                            implicitSize: parent.height
                            source: {
                                if (miniWindow.modelData.wayland?.appId.startsWith("steam_app")) {
                                    return Quickshell.iconPath("input-gaming");
                                } else if (miniWindow.modelData.wayland?.appId == "") {
                                    return (Quickshell.iconPath("image-loading"));
                                } else {
                                    return Quickshell.iconPath(miniWindow.modelData.wayland?.appId.toLowerCase() ?? "image-loading", miniWindow.modelData.wayland?.appId);
                                }
                            }
                        }
                    }
                    Component {
                        id: preview
                        ScreencopyView {
                            anchors.fill: parent
                            captureSource: miniWindow.modelData.wayland
                        }
                    }
                }
            }
        }
    }
}
