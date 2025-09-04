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
    Keys.onDeletePressed: root.currentItem.tapped(undefined, Qt.MiddleButton)
    Keys.onPressed: event => {
        if (event.modifiers === Qt.ControlModifier) {
            switch (event.key) {
            case Qt.Key_O:
                root.currentItem.tapped(undefined, Qt.LeftButton);
                break;
            case Qt.Key_D:
                root.currentItem.tapped(undefined, Qt.MiddleButton);
                break;
            }
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
                margins: Theme.margin
            }
            spacing: Theme.margin

            IconImage {
                Layout.fillHeight: true
                Layout.preferredWidth: height
                source: Quickshell.iconPath(toplevel.modelData?.appId?.toLowerCase() ?? "image-loading", "input-gaming")
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
