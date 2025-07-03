import Quickshell
import QtQuick
import "root:/services"

Row {
  Block {
  color: mouseLeft.containsMouse ? Theme.color.gray : "transparent"
    SymbolText {
      text: "arrow_back"
      color: Theme.color.green
    }
    MouseBlock {
      id: mouseLeft
      onClicked: Hyprland.dispatch("changegroupactive b")
    }
  }
  Block {
  color: mouseRight.containsMouse ? Theme.color.gray : "transparent"
    SymbolText {
      text: "arrow_forward"
      color: Theme.color.green
    }
    MouseBlock {
      id: mouseRight
      onClicked: Hyprland.dispatch("changegroupactive f")
    }
  }
  Block {
    SymbolText {
      text: "close"
      color: Theme.color.red
    }
    MouseBlock {
      id: mouse
      onClicked: Hyprland.activeToplevel.wayland.close()
    }
  }
}
