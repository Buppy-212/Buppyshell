pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root
    PwObjectTracker {
        objects: Pipewire.nodes.values.filter(a => a.audio)
    }
    enum SidebarModule {
        Notifications,
        Volume,
        Bluetooth,
        Network
    }

    enum LauncherModule {
        AppLauncher,
        WindowSwitcher,
        BookmarkLauncher,
        WallpaperSwitcher,
        Logout
    }

    property bool doNotDisturb: false
    property int sidebarModule: GlobalState.SidebarModule.Notifications
    property int launcherModule: GlobalState.LauncherModule.WindowSwitcher
    property bool launcher: false
    property bool sidebar: false
    property bool locked: false

    GlobalShortcut {
        name: "apps"
        description: "Toggle application launcher"
        appid: "buppyshell"
        onPressed: {
            root.launcherModule === GlobalState.LauncherModule.AppLauncher ? root.launcher = !root.launcher : root.launcher = true;
            root.launcherModule = GlobalState.LauncherModule.AppLauncher;
        }
    }

    GlobalShortcut {
        name: "windows"
        description: "Toggle window switcher"
        appid: "buppyshell"
        onPressed: {
            root.launcherModule === GlobalState.LauncherModule.WindowSwitcher ? root.launcher = !root.launcher : root.launcher = true;
            root.launcherModule = GlobalState.LauncherModule.WindowSwitcher;
        }
    }

    GlobalShortcut {
        name: "bookmarks"
        description: "Toggle bookmark launcher"
        appid: "buppyshell"
        onPressed: {
            root.launcherModule === GlobalState.LauncherModule.BookmarkLauncher ? root.launcher = !root.launcher : root.launcher = true;
            root.launcherModule = GlobalState.LauncherModule.BookmarkLauncher;
        }
    }

    GlobalShortcut {
        name: "wallpapers"
        description: "Toggle wallpaper switcher"
        appid: "buppyshell"
        onPressed: {
            root.launcherModule === GlobalState.LauncherModule.WallpaperSwitcher ? root.launcher = !root.launcher : root.launcher = true;
            root.launcherModule = GlobalState.LauncherModule.WallpaperSwitcher;
        }
    }

    GlobalShortcut {
        name: "logout"
        description: "Toggle logout menu"
        appid: "buppyshell"
        onPressed: {
            root.launcherModule === GlobalState.LauncherModule.Logout ? root.launcher = !root.launcher : root.launcher = true;
            root.launcherModule = GlobalState.LauncherModule.Logout;
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
