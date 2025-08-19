pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Qt.labs.folderlistmodel
import qs.utils

Searcher {
    id: root

    property url current
    property list<string> urls
    property FolderListModel foldermodel

    list: wallpapers.instances

    Process {
        id: load

        command: ["readlink", "-n", `${Quickshell.env("XDG_STATE_HOME")}/wallpaper`]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.current = "file:/" + text;
            }
        }
    }

    Variants {
        id: wallpapers

        model: root.urls
        delegate: Wallpaper {}
    }

    Process {
        id: get

        command: ["find", `${Quickshell.env("HOME")}/Pictures/Wallpapers`, "-type", "f"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                root.urls.push(data);
            }
        }
    }
}
