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

    FolderListModel {
        id: folderModel

        folder: `file:${Quickshell.env("HOME")}/Pictures/Wallpapers`
        onCountChanged: {
            root.urls = [];
            root.urls = root.getFilePathsList();
        }
    }

    function getFilePathsList() {
        var pathsList = [];
        for (var i = 0; i < folderModel.count; i++) {
            pathsList.push(folderModel.get(i, "filePath"));
        }
        return pathsList;
    }

    Variants {
        id: wallpapers

        model: root.urls
        delegate: Wallpaper {}
    }
}
