pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import qs.services

Item {
    readonly property int cols: (Screen.width * 0.75 - Theme.margin.large) / appList.cellWidth
    width: cols * appList.cellWidth
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
                    appList.moveCurrentIndexRight();
                    break;
                case Qt.Key_Backtab:
                    appList.moveCurrentIndexLeft();
                    break;
                case Qt.Key_Return:
                    Quickshell.execDetached(["uwsm", "app", "--", `${appList.currentItem.modelData.id}.desktop`]);
                    GlobalState.launcher = false;
                    break;
                }
            }
        }
    }
    GridView {
        id: appList
        readonly property int rows: (Screen.height * 0.9) / appList.cellHeight
        model: Apps.query(input.text)
        clip: true
        cellHeight: Theme.iconSize.large + Theme.height.block * 4
        cellWidth: Theme.iconSize.large * 1.5
        snapMode: GridView.SnapToRow
        highlight: Rectangle {
            color: Theme.color.bgalt
            radius: Theme.radius.normal
        }
        anchors.centerIn: parent
        keyNavigationWraps: true
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        height: rows * cellHeight
        width: parent.width
        displaced: Transition {
            NumberAnimation {
                property: "x"
                duration: Theme.animation.elementMoveFast.duration
                easing.type: Theme.animation.elementMoveFast.type
                easing.bezierCurve: Theme.animation.elementMoveFast.bezierCurve
            }
        }
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
                height: Theme.iconSize.large + Theme.height.block * 4
                width: Theme.iconSize.large * 1.5
                IconImage {
                    x: Theme.iconSize.large / 4
                    implicitSize: Theme.iconSize.large
                    source: Quickshell.iconPath(appDelegate.modelData.icon)
                }
                Text {
                    height: Theme.height.block * 4
                    width: parent.width
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
