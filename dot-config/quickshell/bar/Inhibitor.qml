import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import "root:/services"
import "."

Block {
  Text {
    text: Idle.active ? "visibility_off" : "visibility"
    color: Theme.color.cyan
    font.pointSize: Theme.font.size.large
    font.family: Theme.font.family.material
    anchors.centerIn: parent
  }
  MouseBlock {
    id: mouse
    readonly property var inhibitorOff: Process {
      command: ["inhibitor", "off"]
    }
    readonly property var inhibitorOn: Process {
      command: ["inhibitor", "on"]
    }
    onClicked: {
      if (Idle.active) {
        inhibitorOn.startDetached()
      } else {
        inhibitorOff.startDetached()
      }
    }
  }
  GlobalShortcut {
    name: "inhibitor"
    description: "Toggle idle inhibitor"
    appid: "buppyshell"
    onPressed: Idle.active ? mouse.inhibitorOn.startDetached() : mouse.inhibitorOff.startDetached()
  }
}
