import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import "root:/services"
import "."

Block {
  Text {
    text: mouse.containsMouse ? Brightness.brightness : Brightness.nightlight ? "bedtime" : "light_mode"
    color: Theme.color.yellow
    font.family: mouse.containsMouse ? Theme.font.family.mono : Theme.font.family.material
    font.pointSize: mouse.containsMouse ? Theme.font.size.normal : Theme.font.size.large
    font.bold: true
    anchors.centerIn: parent
  }
  MouseBlock {
    id: mouse
    readonly property var up: Process {
      command: ["brightness", "up"]
    }
    readonly property var down: Process {
      command: ["brightness", "down"]
    }
    readonly property var monitor: Process {
      command: ["ddcutil", "setvcp", "10", Brightness.brightness]
    }
    readonly property var filterOn: Process {
      command: ["brightness", "filterOn"]
    }
    readonly property var filterOff: Process {
      command: ["brightness", "filterOff"]
    }
    onClicked: (mouse) => {
      if (mouse.button == Qt.LeftButton) {
        console.log(Brightness.nightlight)
        if (Brightness.nightlight) {
          filterOff.startDetached()
        } else {
          filterOn.startDetached()
        }
      } else
      monitor.startDetached()
    }
    onWheel: (wheel) => {
      if (wheel.angleDelta.y > 0) {
        up.startDetached()
      } else {
        down.startDetached()
      }
    }
  }
  GlobalShortcut {
    name: "nightlight"
    description: "Toggles nightlight"
    appid: "buppyshell"
    onPressed: Brightness.nightlight ? mouse.filterOff.startDetached() : mouse.filterOn.startDetached()
  }
}

