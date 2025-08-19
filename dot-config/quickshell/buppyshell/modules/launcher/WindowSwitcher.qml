pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

StyledListView {
    id: root

    required property string search

    Keys.onReturnPressed: root.currentItem.tapped(undefined, Qt.LeftButton)
    Keys.onDeletePressed: root.currentItem.modelData.close()
    Keys.onPressed: event => {
        if (event.modifiers === Qt.ControlModifier && event.key === Qt.Key_O) {
            root.currentItem.tapped(undefined, Qt.LeftButton);
        }
    }
    background: null
    model: Windows.query(root.search)
    delegate: StyledButton {
        id: toplevel

        required property Toplevel modelData
        required property int index

        function tapped(pointEvent, button): void {
            switch (button) {
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
        function entered(): void {
            root.currentIndex = toplevel.index;
        }

        background: null
        implicitHeight: Theme.blockHeight * 4
        implicitWidth: root.width
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
                    if (toplevel?.modelData?.appId?.startsWith("steam_app")) {
                        return Quickshell.iconPath("input-gaming");
                    } else {
                        return Quickshell.iconPath(toplevel?.modelData?.appId?.toLowerCase() ?? "image-loading", toplevel?.modelData?.appId);
                    }
                }
            }
            StyledText {
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pixelSize: Theme.font.size.doubled
                elide: Text.ElideRight
                text: toplevel.modelData?.title ?? ""
                color: toplevel.ListView.isCurrentItem ? Theme.color.accent : Theme.color.fg
                horizontalAlignment: Text.AlignLeft
            }
        }
    }
}
