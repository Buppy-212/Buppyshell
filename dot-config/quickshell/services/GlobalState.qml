pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    property bool defaultTitle: true
    property string title: defaultTitle

    function overrideTitle(title: string): void {
        timer.running = false;
        root.defaultTitle = false;
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
                root.defaultTitle = true;
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
