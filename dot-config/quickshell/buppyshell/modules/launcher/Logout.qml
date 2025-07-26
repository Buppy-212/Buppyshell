pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import qs.services

Item {
    implicitWidth: logoutList.count * (Theme.iconSize.large + Theme.margin.large) + Theme.margin.medium
    implicitHeight: Theme.iconSize.large + Theme.height.block + Theme.margin.large
    Keys.enabled: visible
    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_Return:
            GlobalState.launcher = false;
            Hyprland.dispatch(logoutList.currentItem.command);
            break;
        case Qt.Key_Tab:
            logoutList.incrementCurrentIndex();
            break;
        case Qt.Key_Backtab:
            logoutList.decrementCurrentIndex();
            break;
        case Qt.Key_Escape:
            GlobalState.launcher = false;
            break;
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
        }
    }
    ListView {
        id: logoutList
        orientation: ListView.Horizontal
        spacing: Theme.margin.large
        anchors.fill: parent
        anchors.margins: Theme.margin.medium
        keyNavigationWraps: true
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
            Column {
                width: Theme.iconSize.large
                height: width + Theme.height.block
                spacing: Theme.margin.medium
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
                        pointSize: Theme.font.size.large
                        family: Theme.font.family.mono
                        bold: true
                    }
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
}
