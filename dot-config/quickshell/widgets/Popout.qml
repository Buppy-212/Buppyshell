import Quickshell
import Quickshell.Hyprland
import QtQuick

Scope {
  PanelWindow {
    screen: HyprlandMonitor.focused?.id
    visible: true
  }
}
