pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    enum SidebarModule {
        Notifications,
        Volume,
        Bluetooth,
        Network
    }

    property int sidebarModule: GlobalState.SidebarModule.Notifications
    property bool player: false
    property bool bluetooth: false
    property bool overlayState: false
    property bool overlay: false
    property bool sidebar: false
    property bool locked: false

    function toggle(stateVar: string): void {
        switch (stateVar) {
        case "bluetooth":
            root.sidebarModule = GlobalState.SidebarModule.Bluetooth;
            break;
        case "player":
            root.player = !root.player;
            break;
        case "notifications":
            root.sidebarModule = GlobalState.SidebarModule.Notifications;
            break;
        case "volume":
            root.sidebarModule = GlobalState.SidebarModule.Volume;
            break;
        case "network":
            root.sidebarModule = GlobalState.SidebarModule.Network;
            break;
        }
    }

    GlobalShortcut {
        name: "windows"
        description: "Toggle window switcher"
        appid: "buppyshell"
        onPressed: {
            root.overlay = !root.overlay;
            root.overlayState = true;
        }
    }
    GlobalShortcut {
        name: "logout"
        description: "Toggle logout menu"
        appid: "buppyshell"
        onPressed: {
            root.overlay = !root.overlay;
            root.overlayState = false;
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
}
