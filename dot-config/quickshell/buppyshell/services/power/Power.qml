pragma Singleton

import Quickshell
import QtQuick
import qs.services
import qs.utils

Searcher {
    id: root

    key: "sortName"
    list: [
        PowerOption {
            sortName: "1 Shutdown"
            name: "Shutdown"
            icon: "power_settings_new"
            color: Theme.color.red
            function action(): void {
                Quickshell.execDetached(["systemctl", "poweroff"]);
            }
        },
        PowerOption {
            sortName: "2 Reboot"
            name: "Reboot"
            icon: "restart_alt"
            color: Theme.color.orange
            function action(): void {
                Quickshell.execDetached(["systemctl", "reboot"]);
            }
        },
        PowerOption {
            sortName: "3 Logout"
            name: "Logout"
            icon: "logout"
            color: Theme.color.green
            function action(): void {
                Quickshell.execDetached(["uwsm", "stop"]);
            }
        },
        PowerOption {
            sortName: "4 Suspend"
            name: "Suspend"
            icon: "pause_circle"
            color: Theme.color.blue
            function action(): void {
                Quickshell.execDetached(["systemctl", "suspend"]);
            }
        },
        PowerOption {
            sortName: "5 Lock"
            name: "Lock"
            icon: "lock"
            color: Theme.color.cyan
            function action(): void {
                GlobalState.locked = true;
            }
        },
        PowerOption {
            sortName: "6 Hibernate"
            name: "Hibernate"
            icon: "mode_standby"
            color: Theme.color.magenta
            function action(): void {
                Quickshell.execDetached(["systemctl", "hibernate"]);
            }
        }
    ]
}
