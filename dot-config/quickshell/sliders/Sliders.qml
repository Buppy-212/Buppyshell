import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import "root:/services"

Scope {
  id: root
  property bool visible: false
  required property int input
  required property bool isVolume
  Timer {
    id: timer
    interval: 2000
    running: root.visible
    onTriggered: root.visible = !root.visible
  }
  PanelWindow {
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "buppyshell:slider"
    exclusionMode: ExclusionMode.Ignore
    anchors.bottom: true
    margins.bottom: implicitHeight / 2
    visible: root.visible
    color: "transparent"
    implicitHeight: Screen.height / 20
    implicitWidth: Screen.width / 10
    Rectangle {
      anchors.fill: parent
      color: Theme.color.black
      radius: Theme.rounding * 4
      height: parent.height
      width: parent.width * 0.8
      Row {
        anchors.fill: parent
        anchors.leftMargin: text.width- Theme.border*2
        spacing: Theme.border
        Text {
          id: text
          anchors.verticalCenter: parent.verticalCenter
          text: isVolume ? Pipewire.defaultAudioSink.audio.muted || input == 0 ? "volume_off" : "volume_up" : "light_mode"
          font.family: Theme.font.family.material
          font.pointSize: Theme.font.size.large
          color: Theme.color.fg
        }
        Slider {
          id: slider
          anchors.verticalCenter: parent.verticalCenter
          live: false
          height: text.height / 2
          width: parent.width - text.width * 2
          from: 0
          to: 100
          value: input
          background: Rectangle {
            width: slider.availableWidth
            height: parent.height
            color: Theme.color.gray
            radius: Theme.rounding
            Rectangle {
              width: slider.visualPosition * parent.width
              height: parent.height
              color: isVolume ? Theme.color.blue : Theme.color.yellow
              radius: Theme.rounding
            }
          }
        }
      }
    }
    MouseArea {
      anchors.fill: parent
    }
  }
  GlobalShortcut {
    name: "volume"
    description: "Toggle volume sidebar"
    appid: "buppyshell"
    onPressed: {
      root.visible = true;
      timer.restart();
      root.input = Pipewire.defaultAudioSink?.audio.volume * 100;
      root.isVolume = true;
    }
  }
  GlobalShortcut {
    name: "brightness"
    description: "Toggle brightness sidebar"
    appid: "buppyshell"
    onPressed: {
      root.visible = true;
      timer.restart();
      root.input = Brightness.brightness;
      root.isVolume = false;
    }
  }
}
