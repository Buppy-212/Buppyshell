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
    id: up
    command: ["brightnessctl", "-q", "s", "+5%"]
  }
  Process {
    id: down
    command: ["brightnessctl", "s", "5-%"]
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

  Timer {
    id:timer
    running: false
    interval: 10
    onTriggered: get.running = true
  }

  Process {
    id: get
    command: ["brightnessctl", "g"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.brightness = text/2.55
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
    root.nightlight ? filterOff.startDetached() : filterOn.startDetached()
    root.nightlight = !root.nightlight 
  }

  function inc(): void {
    up.startDetached()
    timer.running = true
  }

  function dec(): void {
    down.startDetached()
    timer.running = true
  }

  function monitor(): void {
    monitor.startDetached()
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
