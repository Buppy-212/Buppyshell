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
        clip: true
        model: Windows.query(root.search)
        snapMode: ListView.SnapToItem
        highlight: Rectangle {
            color: Theme.color.grey
            radius: height / 4
        }
        keyNavigationWraps: true
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        highlightResizeDuration: 0
        anchors.fill: parent
        delegate: StyledButton {
            id: windowDelegate
            required property Toplevel modelData
            required property int index
            function tapped(pointEvent, button) {
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
            function entered() {
                windowList.currentIndex = windowDelegate.index;
            }
            background: null
            implicitHeight: windowList.height / 10
            implicitWidth: windowList.width
            contentItem: RowLayout {
                anchors {
                    fill: parent
                    leftMargin: parent.width / 64
                    topMargin: parent.height / 32
                    bottomMargin: parent.height / 32
                }
                spacing: anchors.leftMargin
                IconImage {
                    Layout.fillHeight: true
                    Layout.preferredWidth: height
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
                StyledText {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pixelSize: height / 4
                    elide: Text.ElideRight
                    text: windowDelegate.modelData?.title ?? ""
                    color: windowDelegate.ListView.isCurrentItem ? Theme.color.accent : Theme.color.fg
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }
    }
}
