pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root
    property bool active

    Process {
        command: ["pidof", "hypridle"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.active = text
        }
    }
    function toggleInhibitor(): void {
        root.active ? Quickshell.execDetached(["systemctl", "--user", "stop", "hypridle"]) : Quickshell.execDetached(["systemctl", "--user", "start", "hypridle"]);
        root.active = !root.active;
    }

    GlobalShortcut {
        name: "inhibitor"
        description: "Toggle idle inhibitor"
        appid: "buppyshell"
        onPressed: root.toggleInhibitor()
    }
}
