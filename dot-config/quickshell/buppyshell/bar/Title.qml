import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import "../services"

Item {
  implicitWidth: 30
  StyledText {
    text: GlobalState.defaultTitle ? Hyprland.focusedWorkspace?.toplevels.values.length ? ToplevelManager.activeToplevel?.title ?? qsTr("Desktop") : qsTr("Desktop") : GlobalState.title
    horizontalAlignment: Text.AlignHCenter
    width: parent.height
    elide: Text.ElideRight
    transform: Rotation {
      angle: 270
      origin.x: height/2 + 4
      origin.y: width/2
    }
  }
  MouseBlock {
    onClicked: Hyprland.dispatch("global buppyshell:windows")
  }
}
