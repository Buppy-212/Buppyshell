pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import qs.services

Item {
    id: root
    Keys.enabled: visible
    Keys.onPressed: event => {
        if (event.modifiers & Qt.ControlModifier) {
            switch (event.key) {
            case Qt.Key_J:
                logoutList.moveCurrentIndexDown();
                break;
            case Qt.Key_K:
                logoutList.moveCurrentIndexUp();
                break;
            case Qt.Key_L:
                logoutList.moveCurrentIndexRight();
                break;
            case Qt.Key_H:
                logoutList.moveCurrentIndexLeft();
                break;
            case Qt.Key_N:
                logoutList.moveCurrentIndexRight();
                break;
            case Qt.Key_P:
                logoutList.moveCurrentIndexLeft();
                break;
            case Qt.Key_O:
                GlobalState.launcher = false;
                Hyprland.dispatch(logoutList.currentItem.command);
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
            case Qt.Key_S:
                GlobalState.launcher = false;
                Quickshell.execDetached(["systemctl", "poweroff"]);
                break;
            case Qt.Key_R:
                GlobalState.launcher = false;
                Quickshell.execDetached(["systemctl", "reboot"]);
                break;
            case Qt.Key_O:
                GlobalState.launcher = false;
                Quickshell.execDetached(["uwsm", "stop"]);
                break;
            case Qt.Key_L:
                GlobalState.launcher = false;
                GlobalState.locked = true;
                break;
            case Qt.Key_U:
                GlobalState.launcher = false;
                Quickshell.execDetached(["systemctl", "suspend"]);
                break;
            case Qt.Key_H:
                GlobalState.launcher = false;
                Quickshell.execDetached(["systemctl", "hibernate"]);
                break;
            case Qt.Key_Return:
                GlobalState.launcher = false;
                Hyprland.dispatch(logoutList.currentItem.command);
                break;
            case Qt.Key_Tab:
                logoutList.moveCurrentIndexRight();
                break;
            case Qt.Key_Backtab:
                logoutList.moveCurrentIndexLeft();
                break;
            case Qt.Key_Down:
                logoutList.moveCurrentIndexDown();
                break;
            case Qt.Key_Up:
                logoutList.moveCurrentIndexUp();
                break;
            case Qt.Key_Right:
                logoutList.moveCurrentIndexRight();
                break;
            case Qt.Key_Left:
                logoutList.moveCurrentIndexLeft();
                break;
            case Qt.Key_Escape:
                GlobalState.launcher = false;
                break;
            }
        }
    }
    GridView {
        id: logoutList
        cellHeight: parent.height / 2
        cellWidth: parent.width / 4
        width: cellWidth * 3
        height: parent.height
        anchors.centerIn: parent
        highlight: Rectangle {
            color: Theme.color.bgalt
            radius: Theme.radius.normal
        }
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        model: [
            {
                icon: "power_settings_new",
                color: Theme.color.red,
                command: "exec systemctl poweroff",
                text: `<font color=${Theme.color.red}>S</font>hutdown`
            },
            {
                icon: "restart_alt",
                color: Theme.color.orange,
                command: "exec systemctl reboot",
                text: `<font color=${Theme.color.orange}>R</font>eboot`
            },
            {
                icon: "logout",
                color: Theme.color.green,
                command: "exec uwsm stop",
                text: `L<font color=${Theme.color.green}>o</font>gout`
            },
            {
                icon: "lock",
                color: Theme.color.cyan,
                command: "global buppyshell:lock",
                text: `<font color=${Theme.color.cyan}>L</font>ock`
            },
            {
                icon: "pause_circle",
                color: Theme.color.blue,
                command: "exec systemctl suspend",
                text: `S<font color=${Theme.color.blue}>u</font>spend`
            },
            {
                icon: "mode_standby",
                color: Theme.color.magenta,
                command: "exec systemctl hibernate",
                text: `<font color=${Theme.color.magenta}>H</font>ibernate`
            },
        ]
        delegate: WrapperMouseArea {
            id: logoutDelegate
            required property string icon
            required property string color
            required property string command
            required property string text
            required property int index
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: logoutList.currentIndex = logoutDelegate.index
            onClicked: {
                GlobalState.launcher = false;
                Hyprland.dispatch(command);
            }
            Item {
                implicitHeight: logoutList.cellHeight
                implicitWidth: logoutList.cellWidth
                Column {
                    anchors.centerIn: parent
                    width: parent.width / 2
                    height: parent.height * 0.75
                    spacing: Theme.margin.large
                    Text {
                        text: logoutDelegate.icon
                        font.family: Theme.font.family.material
                        font.pixelSize: height
                        color: logoutDelegate.color
                        width: parent.width
                        height: width
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text {
                        text: logoutDelegate.text
                        textFormat: Text.MarkdownText
                        width: parent.width
                        color: Theme.color.fg
                        font {
                            pointSize: Theme.font.size.huge
                            family: Theme.font.family.mono
                            bold: true
                        }
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
    }
}
