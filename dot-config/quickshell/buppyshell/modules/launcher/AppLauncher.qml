pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
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
                appList.moveCurrentIndexDown();
                break;
            case Qt.Key_K:
                appList.moveCurrentIndexUp();
                break;
            case Qt.Key_L:
                appList.moveCurrentIndexRight();
                break;
            case Qt.Key_H:
                appList.moveCurrentIndexLeft();
                break;
            case Qt.Key_N:
                appList.moveCurrentIndexRight();
                break;
            case Qt.Key_P:
                appList.moveCurrentIndexLeft();
                break;
            case Qt.Key_O:
                Quickshell.execDetached(["uwsm", "app", "--", `${appList.currentItem.modelData.id}.desktop`]);
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
                appList.moveCurrentIndexRight();
                break;
            case Qt.Key_Backtab:
                appList.moveCurrentIndexLeft();
                break;
            case Qt.Key_Down:
                appList.moveCurrentIndexDown();
                break;
            case Qt.Key_Up:
                appList.moveCurrentIndexUp();
                break;
            case Qt.Key_Right:
                appList.moveCurrentIndexRight();
                break;
            case Qt.Key_Left:
                appList.moveCurrentIndexLeft();
                break;
            case Qt.Key_Return:
                Quickshell.execDetached(["uwsm", "app", "--", `${appList.currentItem.modelData.id}.desktop`]);
                GlobalState.launcher = false;
                break;
            }
        }
    }
    GridView {
        id: appList
        readonly property int rows: parent.height / appList.cellHeight
        readonly property int cols: parent.width * 0.75 / appList.cellWidth
        model: Apps.query(root.search)
        clip: true
        cellHeight: Theme.iconSize.large + Theme.height.block * 3 + Theme.margin.large
        cellWidth: Theme.iconSize.large * 1.5
        snapMode: GridView.SnapToRow
        highlight: Rectangle {
            color: Theme.color.bgalt
            radius: Theme.radius.normal
        }
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        width: cols * appList.cellWidth
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
            onEntered: appList.currentIndex = appDelegate.index
            Column {
                height: appList.cellHeight
                width: appList.cellWidth
                topPadding: Theme.margin.medium
                bottomPadding: Theme.margin.medium
                IconImage {
                    x: Theme.iconSize.large / 4
                    y: Theme.height.block
                    implicitSize: Theme.iconSize.large
                    source: Quickshell.iconPath(appDelegate.modelData.icon)
                }
                Text {
                    height: Theme.height.block * 3
                    width: parent.width
                    padding: Theme.margin.tiny
                    text: modelData.name
                    color: Theme.color.fg
                    wrapMode: Text.Wrap
                    font {
                        family: Theme.font.family.mono
                        pointSize: Theme.font.size.normal
                        bold: true
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}
