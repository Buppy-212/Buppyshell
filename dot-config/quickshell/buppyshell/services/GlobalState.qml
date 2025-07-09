pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    property bool overlayState: false
    property bool overlay: false
    property bool sidebar: false
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
        }
    }
    GlobalShortcut {
        name: "windows"
        description: "Toggle window switcher"
        appid: "buppyshell"
        onPressed: {
            root.overlay = !root.overlay;
            root.overlayState = true
        }
    }
    GlobalShortcut {
        name: "logout"
        description: "Toggle logout menu"
        appid: "buppyshell"
        onPressed: {
          root.overlay = !root.overlay;
          root.overlayState = false
        }
    }
    GlobalShortcut {
        name: "sidebar"
        description: "Toggle sidebar"
        appid: "buppyshell"
        onPressed: {
            root.sidebar = !root.sidebar;
        }
    }
    GlobalShortcut {
        name: "lock"
        description: "Reloads toplevels"
        appid: "buppyshell"
        onPressed: root.locked = true
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
