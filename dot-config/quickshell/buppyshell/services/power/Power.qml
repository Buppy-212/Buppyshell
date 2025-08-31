pragma Singleton

import Quickshell
import QtQuick
import qs.services
import qs.utils

Searcher {
    id: root

    sort: false
    list: [
        PowerOption {
            name: "Shutdown"
            icon: "power_settings_new"
            color: Theme.color.red
            function action(): void {
                Quickshell.execDetached(["systemctl", "poweroff"]);
            }
        },
        PowerOption {
            name: "Reboot"
            icon: "restart_alt"
            color: Theme.color.orange
            function action(): void {
                Quickshell.execDetached(["systemctl", "reboot"]);
            }
        },
        PowerOption {
            name: "Logout"
            icon: "logout"
            color: Theme.color.green
            function action(): void {
                Quickshell.execDetached(["uwsm", "stop"]);
            }
        },
        PowerOption {
            name: "Suspend"
            icon: "pause_circle"
            color: Theme.color.blue
            function action(): void {
                Quickshell.execDetached(["systemctl", "suspend"]);
            }
        },
        PowerOption {
            name: "Lock"
            icon: "lock"
            color: Theme.color.cyan
            function action(): void {
                GlobalState.locked = true;
            }
        },
        PowerOption {
            name: "Hibernate"
            icon: "mode_standby"
            color: Theme.color.magenta
            function action(): void {
                Quickshell.execDetached(["systemctl", "hibernate"]);
            }
        }
    ]
}
