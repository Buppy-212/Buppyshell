import Quickshell
import QtQuick
import "root:/services"

Row {
  visible: Hyprland.focusedWorkspace.toplevels.values.length
  Block {
  visible: Hyprland.groupLength >= 2
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
  visible: Hyprland.groupLength >= 2
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
  visible: Hyprland.grouped
  color: mouseLock.containsMouse ? Theme.color.gray : "transparent"
    SymbolText {
      text: Hyprland.locked ? "lock_open" : "lock"
      color: Theme.color.orange
    }
    MouseBlock {
      id: mouseLock
      onClicked: { Hyprland.dispatch("lockactivegroup toggle"); Hyprland.dispatch("tagwindow locked"); Hyprland.reload() }
    }
  }
  Block {
  color: mouseGroup.containsMouse ? Theme.color.gray : "transparent"
    SymbolText {
      text: Hyprland.grouped ? "tab" : "tab_group"
      color: Theme.color.green
    }
    MouseBlock {
      id: mouseGroup
      onClicked: { Hyprland.dispatch("togglegroup"); Hyprland.dispatch("tagwindow -- -locked") }
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
