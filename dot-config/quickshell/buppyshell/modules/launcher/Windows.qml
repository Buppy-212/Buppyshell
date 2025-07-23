pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import "../../services"

ClippingRectangle {
    anchors.centerIn: parent
    radius: Theme.radius.normal
    implicitWidth: windowList.count * (Theme.iconSize.large + Theme.margin.medium) + Theme.margin.medium < Screen.width ? windowList.count * (Theme.iconSize.large + Theme.margin.medium) + Theme.margin.medium : Screen.width
    implicitHeight: Theme.iconSize.large + Theme.height.block + Theme.margin.large
    color: Theme.color.bg
    Column {
        width: parent.width - Theme.margin.large
        height: parent.height - Theme.margin.large
        x: Theme.margin.medium
        y: x
        spacing: Theme.margin.tiny
        ListView {
            id: windowList
            property string hoveredTitle
            model: ToplevelManager.toplevels
            orientation: ListView.Horizontal
            spacing: Theme.margin.medium
            snapMode: ListView.SnapToItem
            highlight: Rectangle {
                color: Theme.color.grey
                radius: Theme.radius.normal
            }
            keyNavigationWraps: true
            highlightFollowsCurrentItem: true
            highlightMoveDuration: 0
            width: parent.width
            height: Theme.iconSize.large
            focus: visible
            displaced: Transition {
                NumberAnimation {
                    property: "x"
                    duration: Theme.animation.elementMoveFast.duration
                    easing.type: Theme.animation.elementMoveFast.type
                    easing.bezierCurve: Theme.animation.elementMoveFast.bezierCurve
                }
            }
            delegate: WrapperMouseArea {
                id: windowDelegate
                required property Toplevel modelData
                required property int index
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                focus: modelData.activated
                focusPolicy: Qt.TabFocus
                Keys.onPressed: event => {
                    switch (event.key) {
                    case Qt.Key_Escape:
                        GlobalState.overlay = false;
                        break;
                    case Qt.Key_Delete:
                        modelData.close();
                        break;
                    case Qt.Key_Return:
                        Hyprland.dispatch(`focuswindow address:0x${modelData.HyprlandToplevel.handle.address}`);
                        GlobalState.overlay = false;
                        break;
                    case Qt.Key_Space:
                        Hyprland.dispatch(`focuswindow address:0x${modelData.HyprlandToplevel.handle.address}`);
                        GlobalState.overlay = false;
                        break;
                    }
                }
                onEntered: {
                    focus = true;
                }
                onFocusChanged: {
                    windowList.hoveredTitle = modelData.title;
                    if (focus) {
                        windowList.currentIndex = index;
                    }
                }
                onClicked: mouse => {
                    switch (mouse.button) {
                    case Qt.LeftButton:
                        Hyprland.dispatch(`focuswindow address:0x${modelData.HyprlandToplevel.handle.address}`);
                        GlobalState.overlay = false;
                        break;
                    case Qt.MiddleButton:
                        modelData.close();
                        break;
                    case Qt.RightButton:
                        Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedWorkspace.id}, address:0x${modelData.HyprlandToplevel.handle.address}`);
                        GlobalState.overlay = false;
                        break;
                    }
                }
                Rectangle {
                    implicitHeight: Theme.iconSize.large
                    implicitWidth: Theme.iconSize.large
                    color: windowDelegate.focus ? Theme.color.grey : "transparent"
                    radius: Theme.radius.normal
                    IconImage {
                        implicitSize: Theme.iconSize.large
                        source: {
                            if (windowDelegate.modelData?.appId.startsWith("steam_app")) {
                                return Quickshell.iconPath("input-gaming");
                            } else if (windowDelegate.modelData?.appId == "") {
                                return (Quickshell.iconPath("image-loading"));
                            } else {
                                return Quickshell.iconPath(windowDelegate.modelData?.appId.toLowerCase() ?? "image-loading", windowDelegate.modelData?.appId);
                            }
                        }
                    }
                }
            }
        }
        Text {
            height: Theme.height.block
            width: parent.width
            text: windowList.hoveredTitle
            color: Theme.color.fg
            font {
                family: Theme.font.family.mono
                pointSize: Theme.font.size.normal
                bold: true
            }
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
