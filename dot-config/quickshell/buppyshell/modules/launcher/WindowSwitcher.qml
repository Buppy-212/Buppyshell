pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import qs.services

Item {
    readonly property int cols: (Screen.width * 0.75 - Theme.margin.large) / (Theme.iconSize.large * 1.5)
    width: cols * Theme.iconSize.large * 1.5
    height: parent.height
    anchors.horizontalCenter: parent.horizontalCenter
    Keys.onEscapePressed: GlobalState.launcher = false
    Rectangle {
        implicitWidth: Screen.width / 3
        implicitHeight: Theme.height.doubleBlock
        radius: Theme.radius.large
        color: Theme.color.bgalt
        anchors.horizontalCenter: parent.horizontalCenter
        y: Theme.height.block
        TextInput {
            id: input
            clip: true
            onVisibleChanged: text = ""
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            leftPadding: Theme.margin.large
            rightPadding: Theme.margin.large
            focus: visible
            color: Theme.color.fg
            font.pointSize: Theme.font.size.normal
            font.family: Theme.font.family.mono
            font.bold: true
            Keys.onPressed: event => {
                switch (event.key) {
                case Qt.Key_Tab:
                    windowList.incrementCurrentIndex();
                    break;
                case Qt.Key_Backtab:
                    windowList.decrementCurrentIndex();
                    break;
                case Qt.Key_Delete:
                    windowList.currentItem.modelData.close();
                    break;
                case Qt.Key_Return:
                    Hyprland.dispatch(`focuswindow address:0x${windowList.currentItem.modelData.HyprlandToplevel.handle.address}`);
                    GlobalState.launcher = false;
                    break;
                }
            }
        }
    }
    ListView {
        id: windowList
        readonly property int rows: (Screen.height * 0.9) / (Theme.iconSize.large + Theme.margin.medium * 3)
        clip: true
        model: Windows.query(input.text)
        spacing: Theme.margin.medium
        snapMode: ListView.SnapToItem
        highlight: Rectangle {
            color: Theme.color.bgalt
            radius: Theme.radius.normal
        }
        anchors.centerIn: parent
        keyNavigationWraps: true
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        highlightResizeDuration: 0
        height: rows * (Theme.iconSize.large + Theme.margin.medium * 3)
        width: parent.width
        displaced: Transition {
            NumberAnimation {
                property: "y"
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
            onClicked: mouse => {
                switch (mouse.button) {
                case Qt.LeftButton:
                    Hyprland.dispatch(`focuswindow address:0x${modelData.HyprlandToplevel.handle.address}`);
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
            onEntered: windowList.currentIndex = windowDelegate.index
            Row {
                height: Theme.iconSize.large
                width: windowList.width
                anchors.fill: parent
                spacing: Theme.margin.large
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
                Text {
                    height: parent.height
                    width: windowList.width - Theme.iconSize.large - Theme.margin.large
                    text: windowDelegate.modelData?.title ?? ""
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
        }
    }
}
