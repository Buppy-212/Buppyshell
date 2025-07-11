pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import "../../services"

Item {
    anchors.fill: parent
    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_Escape:
            Hyprland.dispatch("global buppyshell:logout");
            break;
        case Qt.Key_S:
            Hyprland.dispatch("global buppyshell:logout");
            Quickshell.execDetached(["systemctl", "poweroff"]);
            break;
        case Qt.Key_R:
            Hyprland.dispatch("global buppyshell:logout");
            Quickshell.execDetached(["systemctl", "reboot"]);
            break;
        case Qt.Key_O:
            Hyprland.dispatch("global buppyshell:logout");
            Quickshell.execDetached(["uwsm", "stop"]);
            break;
        case Qt.Key_L:
            Hyprland.dispatch("global buppyshell:logout");
            GlobalState.toggleLock();
            break;
        case Qt.Key_U:
            Hyprland.dispatch("global buppyshell:logout");
            Quickshell.execDetached(["systemctl", "suspend"]);
            break;
        case Qt.Key_H:
            Hyprland.dispatch("global buppyshell:logout");
            Quickshell.execDetached(["systemctl", "hibernate"]);
        }
    }
    Repeater {
        id: rep
        model: [
            {
                icon: "power_settings_new",
                color: Theme.color.red,
                command: "exec systemctl poweroff",
                shortcut: "s"
            },
            {
                icon: "restart_alt",
                color: Theme.color.orange,
                command: "exec systemctl reboot",
                shortcut: "r"
            },
            {
                icon: "logout",
                color: Theme.color.green,
                command: "exec uwsm stop",
                shortcut: "o"
            },
            {
                icon: "lock",
                color: Theme.color.cyan,
                command: "global buppyshell:lock",
                shortcut: "l"
            },
            {
                icon: "pause_circle",
                color: Theme.color.blue,
                command: "exec systemctl suspend",
                shortcut: "u"
            },
            {
                icon: "mode_standby",
                color: Theme.color.magenta,
                command: "exec systemctl hibernate",
                shortcut: "h"
            },
        ]
        delegate: WrapperMouseArea {
            id: logoutItem
            required property string icon
            required property string color
            required property string command
            required property string shortcut
            required property int index
            x: parent.width / 2 + Screen.height / 3 * Math.cos(2 * Math.PI * (index - 2) / rep.count) - width / 2
            y: parent.height / 2 + Screen.height / 3 * Math.sin(2 * Math.PI * (index - 2) / rep.count) - height / 2
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            focus: index ? false : true
            focusPolicy: Qt.StrongFocus
            onEntered: focus = true
            onClicked: {
                Hyprland.dispatch("global buppyshell:logout");
                Hyprland.dispatch(command);
            }
            Keys.onReturnPressed: {
                Hyprland.dispatch("global buppyshell:logout");
                Hyprland.dispatch(command);
            }
            Rectangle {
                implicitWidth: Screen.width * 0.1
                implicitHeight: width
                radius: width
                color: logoutItem.focus ? Theme.color.grey : Theme.color.black
                Text {
                    text: logoutItem.icon
                    anchors.centerIn: parent
                    font.family: Theme.font.family.material
                    font.pointSize: parent.width ? parent.width / 2 : 1
                    color: logoutItem.color
                }
                Text {
                    text: logoutItem.shortcut
                    font.pointSize: parent.width ? parent.width * 0.1 : 1
                    font.family: Theme.font.family.mono
                    color: Theme.color.fg
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                }
            }
        }
    }
}
