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
  readonly property var focusedWorkspace: Hyprland.focusedWorkspace
  readonly property var activeToplevel: Hyprland.activeToplevel
  readonly property string defaultTitle: Hyprland.activeToplevel?.title ?? "Desktop"
  property string title: defaultTitle

  function reload() {
    Hyprland.refreshWorkspaces();
    Hyprland.refreshMonitors();
    Hyprland.refreshToplevels();
  }

  function overrideTitle(title: string): void {
    timer.running = false;
    root.title = title;
  }

  function refreshTitle() {
    timer.restart();
  }

  function dispatch(request: string): void {
    Hyprland.dispatch(request);
  }

  Connections {
    target: Hyprland

    function onRawEvent(event: HyprlandEvent): void {
      if (event.name == "togglegroup") {
        root.reload();
      }
      timer.restart();
    }
  }
  Timer {
    id: timer
    interval: 200
    running: true
    onTriggered: {
      if (Hyprland.focusedWorkspace?.toplevels.values.length == 0) {
        root.title = "Desktop";
      } else {
        root.title = root.defaultTitle;
      }
    }
  }
  GlobalShortcut {
    name: "reload"
    description: "Reloads hyprland vars"
    appid: "buppyshell"
    onPressed: root.reload()
  }
}
