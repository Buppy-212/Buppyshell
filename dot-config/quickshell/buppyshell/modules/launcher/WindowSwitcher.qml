pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import qs.services

Item {
    id: root
    required property string search
    Keys.enabled: visible
    Keys.onPressed: event => {
        if (event.modifiers & Qt.ControlModifier) {
            switch (event.key) {
            case Qt.Key_J:
                windowList.incrementCurrentIndex();
                break;
            case Qt.Key_K:
                windowList.decrementCurrentIndex();
                break;
            case Qt.Key_N:
                windowList.incrementCurrentIndex();
                break;
            case Qt.Key_P:
                windowList.decrementCurrentIndex();
                break;
            case Qt.Key_O:
                Quickshell.execDetached(["hyprctl", "dispatch", "focuswindow", `address:0x${windowList.currentItem.modelData.HyprlandToplevel.handle.address}`]);
                GlobalState.launcher = false;
                break;
            case Qt.Key_Semicolon:
                GlobalState.launcher = false;
                break;
            case Qt.Key_C:
                GlobalState.launcher = false;
                break;
            }
        } else {
            switch (event.key) {
            case Qt.Key_Tab:
                windowList.incrementCurrentIndex();
                break;
            case Qt.Key_Backtab:
                windowList.decrementCurrentIndex();
                break;
            case Qt.Key_Down:
                windowList.incrementCurrentIndex();
                break;
            case Qt.Key_Up:
                windowList.decrementCurrentIndex();
                break;
            case Qt.Key_Delete:
                windowList.currentItem.modelData.close();
                break;
            case Qt.Key_Escape:
                GlobalState.launcher = false;
                break;
            case Qt.Key_Return:
                Quickshell.execDetached(["hyprctl", "dispatch", "focuswindow", `address:0x${windowList.currentItem.modelData.HyprlandToplevel.handle.address}`]);
                GlobalState.launcher = false;
                break;
            }
        }
    }
    ListView {
        id: windowList
        readonly property int rows: parent.height / (Theme.iconSize.large + Theme.margin.medium)
        readonly property int cols: parent.width * 0.75 / (Theme.iconSize.large * 1.5)
        clip: true
        model: Windows.query(root.search)
        spacing: Theme.margin.medium
        snapMode: ListView.SnapToItem
        highlight: Rectangle {
            color: Theme.color.bgalt
            radius: Theme.radius.normal
        }
        keyNavigationWraps: true
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        highlightResizeDuration: 0
        height: rows * (Theme.iconSize.large + Theme.margin.medium)
        width: cols * Theme.iconSize.large * 1.5
        anchors.centerIn: parent
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
                    Quickshell.execDetached(["hyprctl", "dispatch", "focuswindow", `address:0x${modelData.HyprlandToplevel.handle.address}`]);
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
