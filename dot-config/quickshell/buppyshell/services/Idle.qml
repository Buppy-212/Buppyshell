pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
  id: root
  property bool active
  Process {
    id: inhibitorOff
    command: ["systemctl", "--user", "start", "hypridle"]
  }
  Process {
    id: inhibitorOn
    command: ["systemctl", "--user", "stop", "hypridle"]
  }
  Process {
    command: ["pidof", "hypridle"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.active = text
    }
  }
  function toggleInhibitor(): void {
    root.active ? inhibitorOn.startDetached() : inhibitorOff.startDetached()
    root.active = !root.active
  }

  function inhibitorOn(): void {
    inhibitorOn.startDetached()
  }

  GlobalShortcut {
    name: "inhibitor"
    description: "Toggle idle inhibitor"
    appid: "buppyshell"
    onPressed: root.toggleInhibitor()
  }
}
