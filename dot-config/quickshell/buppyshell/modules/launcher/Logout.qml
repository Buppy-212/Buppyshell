pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.services
import qs.widgets

StyledGridView {
    id: root
    Keys.onPressed: event => {
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
            root.currentItem.tapped();
            break;
        }
    }
    background: null
    cellHeight: height / 2
    cellWidth: width / 3
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
    delegate: StyledButton {
        id: logoutDelegate
        required property string icon
        required property string color
        required property string command
        required property string text
        required property int index
        background: null
        function tapped(): void {
            GlobalState.launcher = false;
            Hyprland.dispatch(command);
        }
        function entered(): void {
            root.currentIndex = logoutDelegate.index;
        }
        implicitHeight: root.cellHeight
        implicitWidth: root.cellWidth
        contentItem: Column {
            anchors {
                fill: parent
                topMargin: parent.height / 8
                rightMargin: parent.width / 4
                bottomMargin: parent.height / 8
                leftMargin: parent.width / 4
            }
            spacing: parent.height / 32
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
            }
        }
    }
}
