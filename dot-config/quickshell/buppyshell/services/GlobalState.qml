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

    enum LauncherModule {
        Windows,
        Logout,
        Apps
    }

    property int sidebarModule: GlobalState.SidebarModule.Notifications
    property bool player: false
    property bool bluetooth: false
    property int launcherModule: GlobalState.LauncherModule.Windows
    property bool launcher: false
    property bool sidebar: false
    property bool locked: false
    property bool bar: true

    function toggle(stateVar: string): void {
        switch (stateVar) {
        case "bluetooth":
            root.sidebarModule = GlobalState.SidebarModule.Bluetooth;
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
        name: "bar"
        description: "Toggle bar visibility"
        appid: "buppyshell"
        onPressed: {
            root.bar = !root.bar;
        }
    }
    GlobalShortcut {
        name: "windows"
        description: "Toggle window switcher"
        appid: "buppyshell"
        onPressed: {
            root.launcherModule == GlobalState.LauncherModule.Windows ? root.launcher = !root.launcher : root.launcher = true;
            root.launcherModule = GlobalState.LauncherModule.Windows;
        }
    }
    GlobalShortcut {
        name: "logout"
        description: "Toggle logout menu"
        appid: "buppyshell"
        onPressed: {
            root.launcherModule == GlobalState.LauncherModule.Logout ? root.launcher = !root.launcher : root.launcher = true;
            root.launcherModule = GlobalState.LauncherModule.Logout;
        }
    }
    GlobalShortcut {
        name: "apps"
        description: "Toggle application launcher"
        appid: "buppyshell"
        onPressed: {
            root.launcherModule == GlobalState.LauncherModule.Apps ? root.launcher = !root.launcher : root.launcher = true;
            root.launcherModule = GlobalState.LauncherModule.Apps;
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
