pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

StyledListView {
    id: root

    interactive: false
    Keys.onReturnPressed: root.currentItem.tapped()
    Keys.onPressed: event => {
        if (event.modifiers === Qt.NoModifier) {
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
            }
        }
    }
    background: null
    model: [
        {
            icon: "power_settings_new",
            color: Theme.color.red,
            command: "exec systemctl poweroff",
            text: "Shutdown"
        },
        {
            icon: "restart_alt",
            color: Theme.color.orange,
            command: "exec systemctl reboot",
            text: "Reboot"
        },
        {
            icon: "logout",
            color: Theme.color.green,
            command: "exec uwsm stop",
            text: "Logout"
        },
        {
            icon: "lock",
            color: Theme.color.cyan,
            command: "global buppyshell:lock",
            text: "Lock"
        },
        {
            icon: "pause_circle",
            color: Theme.color.blue,
            command: "exec systemctl suspend",
            text: "Suspend"
        },
        {
            icon: "mode_standby",
            color: Theme.color.magenta,
            command: "exec systemctl hibernate",
            text: "Hibernate"
        },
    ]
    delegate: StyledButton {
        id: logoutDelegate

        required property string icon
        required property string color
        required property string command
        required property string text
        required property int index

        function tapped(): void {
            GlobalState.launcher = false;
            Hyprland.dispatch(command);
        }
        function entered(): void {
            root.currentIndex = logoutDelegate.index;
        }

        background: null
        implicitHeight: Theme.blockHeight * 4
        implicitWidth: root.width
        contentItem: RowLayout {
            anchors {
                fill: parent
                margins: Theme.margin
            }
            spacing: Theme.margin

            Text {
                id: symbol

                Layout.fillHeight: true
                Layout.preferredWidth: height
                text: logoutDelegate.icon
                font.family: Theme.font.family.material
                font.pixelSize: height
                color: logoutDelegate.color
                verticalAlignment: Text.AlignVCenter
            }

            StyledText {
                text: logoutDelegate.text
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pixelSize: Theme.font.size.doubled
                color: logoutDelegate.ListView.isCurrentItem ? Theme.color.accent : Theme.color.fg
                horizontalAlignment: Text.AlignLeft
            }
        }
    }
}
