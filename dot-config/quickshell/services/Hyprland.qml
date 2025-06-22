pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Singleton {
  id: root

  readonly property var toplevels: Hyprland.toplevels
  readonly property var workspaces: Hyprland.workspaces
  readonly property var monitors: Hyprland.monitors
  readonly property var focusedMonitor: Hyprland.focusedMonitor
  readonly property var activeToplevel: Hyprland.activeToplevel
  property string title: Hyprland.activeToplevel?.title ?? "Desktop"

  function reload() {
    Hyprland.refreshWorkspaces();
    Hyprland.refreshMonitors();
    Hyprland.refreshToplevels();
  }

  function overrideTitle(title: string): void {
    root.title = title
  }

  function dispatch(request: string): void {
    Hyprland.dispatch(request);
  }


  Connections {
    target: Hyprland

    function onRawEvent(event: HyprlandEvent): void {
      if (!event.name.endsWith("v2"))
      root.reload();
    }
  }
}
