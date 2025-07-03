import Quickshell
import QtQuick
import "root:/services"

Row {
  id: windowControls
  readonly property int groupLength: Hyprland.activeToplevel?.lastIpcObject?.grouped?.length ?? 0
  readonly property bool grouped: groupLength
  readonly property bool locked: Hyprland.activeToplevel?.lastIpcObject?.tags?.includes("locked") ?? false
  visible: Hyprland.focusedWorkspace?.toplevels.values.length ?? false
  Block {
  visible: windowControls.groupLength >= 2
  color: mouseLeft.containsMouse ? Theme.color.gray : "transparent"
    SymbolText {
      text: "arrow_back"
    }
    MouseBlock {
      id: mouseLeft
      onClicked: Hyprland.dispatch("changegroupactive b")
    }
  }
  Block {
  visible: windowControls.groupLength >= 2
  color: mouseRight.containsMouse ? Theme.color.gray : "transparent"
    SymbolText {
      text: "arrow_forward"
    }
    MouseBlock {
      id: mouseRight
      onClicked: Hyprland.dispatch("changegroupactive f")
    }
  }
  Block {
  visible: windowControls.grouped
  color: mouseLock.containsMouse ? Theme.color.gray : "transparent"
    SymbolText {
      text: windowControls.locked ? "lock" : "lock_open"
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
      text: windowControls.grouped ? "tab" : "tab_group"
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
