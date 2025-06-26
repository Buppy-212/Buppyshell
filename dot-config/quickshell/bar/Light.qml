import Quickshell
import Quickshell.Io
import QtQuick
import "root:/services"
import "."

Block {
  property bool nightlight: Brightness.nightlight
  Text {
    text: mouse.containsMouse ? Brightness.brightness : nightlight ? "bedtime" : "light_mode"
    color: Theme.color.yellow
    font.family: mouse.containsMouse ? Theme.font.family.mono : Theme.font.family.material
    font.pointSize: mouse.containsMouse ? Theme.font.size.normal : Theme.font.size.large
    font.bold: true
    anchors.centerIn: parent
  }
  MouseArea {
    id: mouse
    readonly property var up: Process {
      command: ["brightnessctl", "-q", "set", "+5%"]
    }
    readonly property var down: Process {
      command: ["brightnessctl", "-q", "set", "5%-"]
    }
    readonly property var monitor: Process {
      command: ["ddcutil", "setvcp", "10", Brightness.brightness]
    }
    readonly property var filterOn: Process {
      command: ["uwsm", "app", "--", "hyprsunset", "-t", "2500"]
    }
    readonly property var filterOff: Process {
      command: ["pkill", "hyprsunset"]
    }
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.MiddleButton
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    onEntered: Brightness.update()
    onClicked: (mouse) => {
      if (mouse.button == Qt.LeftButton) {
        nightlight = !nightlight;
        if (nightlight) {
          filterOn.startDetached()
        } else {
          filterOff.startDetached()
        }
      } else
      monitor.startDetached()
    }
    onWheel: (wheel) => {
      if (wheel.angleDelta.y > 0) {
        up.startDetached()
        Brightness.update()
      } else {
        down.startDetached()
        Brightness.update()
      }
    }
  }
}


