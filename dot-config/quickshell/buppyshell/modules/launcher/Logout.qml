pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import qs.services
import qs.widgets

Item {
    id: root
    Keys.enabled: visible
    Keys.onPressed: event => {
        if (event.modifiers & Qt.ControlModifier) {
            switch (event.key) {
            case Qt.Key_J:
                logoutGrid.moveCurrentIndexDown();
                break;
            case Qt.Key_K:
                logoutGrid.moveCurrentIndexUp();
                break;
            case Qt.Key_L:
                logoutGrid.moveCurrentIndexRight();
                break;
            case Qt.Key_H:
                logoutGrid.moveCurrentIndexLeft();
                break;
            case Qt.Key_N:
                logoutGrid.moveCurrentIndexRight();
                break;
            case Qt.Key_P:
                logoutGrid.moveCurrentIndexLeft();
                break;
            case Qt.Key_O:
                GlobalState.launcher = false;
                Hyprland.dispatch(logoutGrid.currentItem.command);
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
                Hyprland.dispatch(logoutGrid.currentItem.command);
                break;
            case Qt.Key_Tab:
                logoutGrid.moveCurrentIndexRight();
                break;
            case Qt.Key_Backtab:
                logoutGrid.moveCurrentIndexLeft();
                break;
            case Qt.Key_Down:
                logoutGrid.moveCurrentIndexDown();
                break;
            case Qt.Key_Up:
                logoutGrid.moveCurrentIndexUp();
                break;
            case Qt.Key_Right:
                logoutGrid.moveCurrentIndexRight();
                break;
            case Qt.Key_Left:
                logoutGrid.moveCurrentIndexLeft();
                break;
            case Qt.Key_Escape:
                GlobalState.launcher = false;
                break;
            }
        }
    }
    GridView {
        id: logoutGrid
        readonly property int cols: parent.width / (Theme.iconSize.large * 2)
        cellHeight: height / 2
        cellWidth: width / 3
        width: cols * Theme.iconSize.large * 1.5
        height: parent.height
        anchors.centerIn: parent
        highlight: Rectangle {
            color: Theme.color.grey
            radius: Theme.radius.normal
        }
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        keyNavigationWraps: true
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
            onEntered: logoutGrid.currentIndex = logoutDelegate.index
            onClicked: {
                GlobalState.launcher = false;
                Hyprland.dispatch(command);
            }
            Item {
                implicitHeight: logoutGrid.cellHeight
                implicitWidth: logoutGrid.cellWidth
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
                    StyledText {
                        text: logoutDelegate.text
                        textFormat: Text.MarkdownText
                        width: parent.width
                        font.pixelSize: Theme.font.size.huge
                        color: logoutDelegate.GridView.isCurrentItem ? Theme.color.accent : Theme.color.fg
                        anchors.fill: undefined
                    }
                }
            }
        }
    }
}
