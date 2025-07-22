pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import "../../services"

Rectangle {
    anchors.centerIn: parent
    radius: Theme.rounding
    implicitWidth: logoutList.count * Theme.iconSize.large
    implicitHeight: Theme.iconSize.large + Theme.blockHeight
    color: Theme.color.bg
    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_Escape:
            GlobalState.overlay = false;
            break;
        case Qt.Key_S:
            GlobalState.overlay = false;
            Quickshell.execDetached(["systemctl", "poweroff"]);
            break;
        case Qt.Key_R:
            GlobalState.overlay = false;
            Quickshell.execDetached(["systemctl", "reboot"]);
            break;
        case Qt.Key_O:
            GlobalState.overlay = false;
            Quickshell.execDetached(["uwsm", "stop"]);
            break;
        case Qt.Key_L:
            GlobalState.overlay = false;
            GlobalState.locked = true;
            break;
        case Qt.Key_U:
            GlobalState.overlay = false;
            Quickshell.execDetached(["systemctl", "suspend"]);
            break;
        case Qt.Key_H:
            GlobalState.overlay = false;
            Quickshell.execDetached(["systemctl", "hibernate"]);
        }
    }
    ListView {
        id: logoutList
        orientation: ListView.Horizontal
        anchors.fill: parent
        focus: visible
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
            id: logoutDelegate
            required property string icon
            required property string color
            required property string command
            required property string shortcut
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            focusPolicy: Qt.TabFocus
            onEntered: focus = true
            onClicked: {
                GlobalState.overlay = false;
                Hyprland.dispatch(command);
            }
            Keys.onReturnPressed: {
                GlobalState.overlay = false;
                Hyprland.dispatch(command);
            }
            Column {
              width: Theme.iconSize.large
              height: width + Theme.blockHeight
              Rectangle {
                implicitWidth: parent.width
                implicitHeight: implicitWidth
                radius: Theme.rounding
                color: logoutDelegate.focus ? Theme.color.grey : "transparent"
                Text {
                  text: logoutDelegate.icon
                  font.family: Theme.font.family.material
                  font.pixelSize: height
                  color: logoutDelegate.color
                  height: parent.height
                  verticalAlignment: Text.AlignVCenter
                }
              }
              Text {
                text: logoutDelegate.shortcut
                font.pointSize: Theme.font.size.large
                font.family: Theme.font.family.mono
                color: Theme.color.fg
                font.bold: true
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
              }
            }
          }
        }
      }
