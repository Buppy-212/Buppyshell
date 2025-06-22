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
  readonly property string defaultTitle: Hyprland.activeToplevel?.title ?? "Desktop"
  property string title: defaultTitle

  function reload() {
    Hyprland.refreshWorkspaces();
    Hyprland.refreshMonitors();
    Hyprland.refreshToplevels();
  }

  function overrideTitle(title: string): void {
    root.title = title;
  }

  function refreshTitle() {
    root.title = root.defaultTitle;
    if (Hyprland.workspaces.values[Hyprland.focusedMonitor?.activeWorkspace.id-1].lastIpcObject.windows == 0) {
      root.title = "Desktop";
    } 
  }

  function dispatch(request: string): void {
    Hyprland.dispatch(request);
  }

  Connections {
    target: Hyprland

    function onRawEvent(event: HyprlandEvent): void {
      if (!event.name.endsWith("v2")) {
        root.reload();
      }
      root.title = defaultTitle;
      if (Hyprland.workspaces.values[Hyprland.focusedMonitor?.activeWorkspace.id-1].lastIpcObject.windows == 0) {
        root.title = "Desktop";
      } 
    }
  }
}
