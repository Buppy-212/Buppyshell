pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
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
        model: Apps.query(root.search)
        clip: true
        cellHeight: height / 5
        cellWidth: width / 9
        snapMode: GridView.SnapToRow
        highlight: Rectangle {
            color: Theme.color.grey
            radius: width / 4
        }
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        keyNavigationWraps: true
        anchors.fill: parent
        delegate: MouseArea {
            id: appDelegate
            required property DesktopEntry modelData
            required property int index
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
                Quickshell.execDetached(["uwsm", "app", "--", `${appDelegate.modelData.id}.desktop`]);
                GlobalState.launcher = false;
            }
            onEntered: appGrid.currentIndex = appDelegate.index
            implicitWidth: appGrid.cellWidth
            implicitHeight: appGrid.cellHeight
            ColumnLayout {
                spacing: 0
                anchors {
                    fill: parent
                    topMargin: parent.height / 20
                    rightMargin: parent.width / 20
                    bottomMargin: parent.height / 20
                    leftMargin: parent.width / 20
                }
                IconImage {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height * 0.6
                    Layout.preferredWidth: height
                    source: Quickshell.iconPath(appDelegate.modelData.icon)
                }
                StyledText {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    anchors.fill: undefined
                    text: modelData.name
                    font.pixelSize: height / 4
                    wrapMode: Text.Wrap
                    color: appDelegate.GridView.isCurrentItem ? Theme.color.accent : Theme.color.fg
                }
            }
        }
    }
}
