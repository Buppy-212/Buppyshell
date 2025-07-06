pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    readonly property string defaultTitle: Hyprland.activeToplevel?.title ?? "Desktop"
    property string title: defaultTitle

    function overrideTitle(title: string): void {
        timer.running = false;
        root.title = title;
    }

    function refreshTitle() {
        timer.restart();
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
        description: "Reloads toplevels"
        appid: "buppyshell"
        onPressed: {
            Hyprland.refreshToplevels();
        }
    }
}
