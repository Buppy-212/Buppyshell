pragma Singleton
pragma ComponentBehavior: Bound

import qs.utils
import QtQuick
import Quickshell
import Quickshell.Io

Searcher {
    id: root

    list: bookmarks.instances

    FileView {
        id: fileView

        path: `${Quickshell.env("XDG_STATE_HOME")}/bookmarks.txt`
        watchChanges: true
    }

    Variants {
        id: bookmarks

        model: fileView.text().trim().split("\n")
        delegate: Bookmark {}
    }
}
