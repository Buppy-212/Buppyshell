pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root
    property url path
    Process {
        id: get
        command: ["readlink", "-n", `${Quickshell.env("XDG_STATE_HOME")}/wallpaper`]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.path = "file:/" + text;
            }
        }
    }
    GlobalShortcut {
        name: "wallpaper"
        description: "Refresh wallpaper"
        appid: "buppyshell"
        onPressed: get.running = true
    }
}
