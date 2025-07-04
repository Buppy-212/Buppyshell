import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import "root:/services"

Item {
  property real radius: Screen.height / 3
  focus: true
  anchors.fill: parent
  Keys.onPressed: Hyprland.dispatch("global buppyshell:windows")
  Repeater {
    id: rep
    model: Hyprland.toplevels
    delegate: WrapperMouseArea {
      x: parent.width/2 + radius * Math.cos(2 * Math.PI * index / rep.count) - width/2
      y: parent.height/2 + radius * Math.sin(2 * Math.PI * index / rep.count) - height/2
      Rectangle {
        implicitWidth: rep.count < 4 ? Screen.width / 4 : Screen.width / rep.count
        implicitHeight: rep.count < 4 ? Screen.height / 4 : Screen.height / rep.count
        color: Theme.color.black
        ScreencopyView {
          id: view
          anchors.fill: parent
          captureSource: modelData.wayland
          constraintSize: rep.count < 4 ? Qt.size(Screen.width / 4, Screen.height/ 4) : Qt.size(Screen.width / rep.count, Screen.height / rep.count)
          live: true
        }
        MouseArea {
          id: mouse
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true
          onClicked: (mouse) => {
            if (mouse.button ==  Qt.LeftButton) {
              Hyprland.dispatch("global buppyshell:windows")
              Hyprland.dispatch(`focuswindow address:0x${modelData.address}`) 
            } else if (mouse.button == Qt.RightButton) {
              Hyprland.dispatch("global buppyshell:windows")
              Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedWorkspace.id}, address:0x${modelData.address}`);
            } else {
              modelData.wayland.close()
            }
          }
        }
      }
    }
  }
  Rectangle {
    anchors.centerIn: parent
    implicitWidth: Screen.width * 0.075
    implicitHeight: width
    radius: width
    color: mouse.containsMouse ? Theme.color.gray : Theme.color.black
    Text {
      text: "close"
      anchors.centerIn: parent
      font.family: Theme.font.family.material
      font.pointSize: parent.width ? parent.width / 2 : Theme.font.size.large
      color: Theme.color.fg
    }
    MouseArea {
      id: mouse
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true
      onClicked: Hyprland.dispatch("global buppyshell:windows")
    }
  }
}
