pragma ComponentBehavior: Bound
pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root
    property int brightness
    property bool nightlight
    Process {
        id: set
        command: ["brightnessctl", "-q", "s", `${root.brightness}%`]
    }
    Process {
        id: monitor
        command: ["ddcutil", "setvcp", "10", root.brightness]
    }
    Process {
        id: filterOn
        command: ["uwsm", "app", "--", "hyprsunset", "-t", "2500"]
    }
    Process {
        id: filterOff
        command: ["pkill", "hyprsunset"]
    }

    Process {
        id: get
        command: ["brightnessctl", "g"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.brightness = text / 2.55
        }
    }
    Process {
        command: ["pidof", "hyprsunset"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: if (text) {
                root.nightlight = true;
            } else {
                root.nightlight = false;
            }
        }
    }

    function toggleNightlight(): void {
        root.nightlight ? filterOff.startDetached() : filterOn.startDetached();
        root.nightlight = !root.nightlight;
    }

    function inc(): void {
        if (root.brightness >= 95) {
            root.brightness = 100;
        } else {
            root.brightness += 5;
        }
        set.startDetached();
    }

    function dec(): void {
        if (root.brightness <= 5) {
            root.brightness = 0;
        } else {
            root.brightness -= 5;
        }
        set.startDetached();
    }

    function monitor(): void {
        monitor.startDetached();
    }

    GlobalShortcut {
        name: "nightlight"
        description: "Toggles nightlight"
        appid: "buppyshell"
        onPressed: root.toggleNightlight()
    }
    GlobalShortcut {
        name: "brightnessUp"
        description: "Increase brightness"
        appid: "buppyshell"
        onPressed: root.inc()
    }
    GlobalShortcut {
        name: "brightnessDown"
        description: "Decrease brightness"
        appid: "buppyshell"
        onPressed: root.dec()
    }
}
