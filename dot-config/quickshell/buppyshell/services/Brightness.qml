pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root
    readonly property int brightnessPercentage: brightness * 100
    property real brightness
    property int maxBrightness
    property bool nightlight
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
            onStreamFinished: text ? root.nightlight = true : root.nightlight = false
        }
    }

    function set(): void {
        Quickshell.execDetached(["brightnessctl", "-q", "s", `${root.brightnessPercentage}%`]);
    }
    function toggleNightlight(): void {
        root.nightlight ? Quickshell.execDetached(["pkill", "hyprsunset"]) : Quickshell.execDetached(["uwsm", "app", "--", "hyprsunset", "-t", "2500"]);
        root.nightlight = !root.nightlight;
    }

    function inc(): void {
        root.brightness >= 0.95 ? root.brightness = 1 : root.brightness += 0.05;
        root.set();
    }

    function dec(): void {
        root.brightness <= 0.05 ? root.brightness = 0 : root.brightness -= 0.05;
        root.set();
    }

    function monitor(): void {
        Quickshell.execDetached(["ddcutil", "setvcp", "10", root.brightnessPercentage]);
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
