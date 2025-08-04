pragma ComponentBehavior: Bound
pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root
    property real brightness
    property int maxBrightness
    property bool nightlight
    Process {
        id: set
        command: ["brightnessctl", "-q", "s", `${100 * root.brightness}%`]
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
        command: ["brightnessctl", "m"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.maxBrightness = text;
                get.running = true;
            }
        }
    }
    Process {
        id: get
        command: ["brightnessctl", "g"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: root.brightness = text / root.maxBrightness
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
        if (root.brightness >= 0.95) {
            root.brightness = 1;
        } else {
            root.brightness += 0.05;
        }
        set.startDetached();
    }

    function dec(): void {
        if (root.brightness <= 0.05) {
            root.brightness = 0;
        } else {
            root.brightness -= 0.05;
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
