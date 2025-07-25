pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import qs.services

Rectangle {
    anchors.centerIn: parent
    radius: Theme.radius.normal
    readonly property int cols: (Screen.width * 0.75 - Theme.margin.large) / appList.cellWidth
    readonly property int rows: (Screen.height * 0.9 - header.height - Theme.margin.large) / appList.cellHeight
    implicitWidth: cols * appList.cellWidth + Theme.margin.large
    implicitHeight: rows * appList.cellHeight + header.height + Theme.margin.large
    color: Theme.color.bg
    Keys.onEscapePressed: GlobalState.overlay = false
    Column {
        id: column
        anchors.fill: parent
        anchors.leftMargin: Theme.margin.medium
        anchors.rightMargin: Theme.margin.medium
        spacing: Theme.margin.medium
        Rectangle {
            id: header
            implicitHeight: 36 + Theme.margin.large
            implicitWidth: parent.width
            color: Theme.color.bg
            Rectangle {
                anchors.topMargin: Theme.margin.medium
                anchors.bottomMargin: Theme.margin.medium
                anchors.fill: parent
                radius: Theme.radius.large
                color: Theme.color.grey
                TextInput {
                    id: input
                    clip: true
                    onVisibleChanged: text = ""
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
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
                            GlobalState.overlay = false;
                            break;
                        }
                    }
                }
            }
        }
        GridView {
            id: appList
            model: Apps.query(input.text)
            clip: true
            cellHeight: Theme.iconSize.large + Theme.height.block * 4
            cellWidth: Theme.iconSize.large * 1.5
            snapMode: ListView.SnapToItem
            highlight: Rectangle {
                color: Theme.color.grey
                radius: Theme.radius.normal
            }
            keyNavigationWraps: true
            highlightFollowsCurrentItem: true
            highlightMoveDuration: 0
            width: parent.width
            height: column.height - header.height - column.spacing * 2
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
                    GlobalState.overlay = false;
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
}
