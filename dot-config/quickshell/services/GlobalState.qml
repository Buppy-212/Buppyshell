pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    property bool locked: false
    property bool defaultTitle: true
    property string title: qsTr("Desktop")

    function overrideTitle(title: string): void {
        timer.running = false;
        root.defaultTitle = false;
        root.title = title;
    }

    function refreshTitle(): void {
        timer.restart();
    }

    function toggleLock(): void {
        root.locked = !root.locked;
    }

    Timer {
        id: timer
        interval: 200
        running: true
        onTriggered: {
            root.defaultTitle = true;
            if (!Hyprland.focusedWorkspace?.toplevels.values.length) {
                root.defaultTitle = false;
                root.title = qsTr("Desktop");
            } else {
                root.defaultTitle = true;
            }
        }
    }
    Connections {
      target: Hyprland
      function onRawEvent(event) {
        timer.restart();
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
