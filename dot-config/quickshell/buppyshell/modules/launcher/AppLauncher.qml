pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
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
                appGrid.moveCurrentIndexDown();
                break;
            case Qt.Key_K:
                appGrid.moveCurrentIndexUp();
                break;
            case Qt.Key_L:
                appGrid.moveCurrentIndexRight();
                break;
            case Qt.Key_H:
                appGrid.moveCurrentIndexLeft();
                break;
            case Qt.Key_N:
                appGrid.moveCurrentIndexRight();
                break;
            case Qt.Key_P:
                appGrid.moveCurrentIndexLeft();
                break;
            case Qt.Key_O:
                Quickshell.execDetached(["uwsm", "app", "--", `${appGrid.currentItem.modelData.id}.desktop`]);
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
            case Qt.Key_Escape:
                GlobalState.launcher = false;
                break;
            case Qt.Key_Tab:
                appGrid.moveCurrentIndexRight();
                break;
            case Qt.Key_Backtab:
                appGrid.moveCurrentIndexLeft();
                break;
            case Qt.Key_Down:
                appGrid.moveCurrentIndexDown();
                break;
            case Qt.Key_Up:
                appGrid.moveCurrentIndexUp();
                break;
            case Qt.Key_Right:
                appGrid.moveCurrentIndexRight();
                break;
            case Qt.Key_Left:
                appGrid.moveCurrentIndexLeft();
                break;
            case Qt.Key_Return:
                Quickshell.execDetached(["uwsm", "app", "--", `${appGrid.currentItem.modelData.id}.desktop`]);
                GlobalState.launcher = false;
                break;
            }
        }
    }
    GridView {
        id: appGrid
        readonly property int rows: parent.height / appGrid.cellHeight
        readonly property int cols: parent.width * 0.75 / appGrid.cellWidth
        model: Apps.query(root.search)
        clip: true
        cellHeight: Theme.iconSize.large + Theme.height.block * 3 + Theme.margin.large
        cellWidth: Theme.iconSize.large * 1.5
        snapMode: GridView.SnapToRow
        highlight: Rectangle {
            color: Theme.color.grey
            radius: Theme.radius.normal
        }
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        width: cols * appGrid.cellWidth
        height: rows * cellHeight
        anchors.centerIn: parent
        delegate: WrapperMouseArea {
            id: appDelegate
            required property DesktopEntry modelData
            required property int index
            acceptedButtons: Qt.LeftButton
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
                Quickshell.execDetached(["uwsm", "app", "--", `${appDelegate.modelData.id}.desktop`]);
                GlobalState.launcher = false;
            }
            onEntered: appGrid.currentIndex = appDelegate.index
            Column {
                height: appGrid.cellHeight
                width: appGrid.cellWidth
                topPadding: Theme.margin.medium
                bottomPadding: Theme.margin.medium
                IconImage {
                    x: Theme.iconSize.large / 4
                    y: Theme.height.block
                    implicitSize: Theme.iconSize.large
                    source: Quickshell.iconPath(appDelegate.modelData.icon)
                }
                Item {
                    height: Theme.height.block * 3
                    width: parent.width
                    StyledText {
                        text: modelData.name
                        padding: Theme.margin.tiny
                        wrapMode: Text.Wrap
                        color: appDelegate.GridView.isCurrentItem ? Theme.color.accent : Theme.color.fg
                    }
                }
            }
        }
    }
}
