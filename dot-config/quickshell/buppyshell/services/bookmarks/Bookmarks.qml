pragma Singleton
pragma ComponentBehavior: Bound

import qs.utils
import QtQuick
import Quickshell
import Quickshell.Io

Searcher {
    id: root

    function add(text: string): void {
        var newBookmarkList = bookmarks.instances.map(a => a.name).filter(a => a !== "");
        newBookmarkList.push(text);
        newBookmarkList.sort((a, b) => a.localeCompare(b));
        fileView.setText(newBookmarkList);
    }

    function remove(bookmark: Bookmark): void {
        fileView.setText(bookmarks.instances.filter(a => a !== bookmark).map(a => a.name));
    }

    list: bookmarks.instances

    FileView {
        id: fileView

        path: `${Quickshell.env("XDG_STATE_HOME")}/buppyshell/bookmarks.txt`
    }

    Variants {
        id: bookmarks

        model: fileView.text().trim().split(",")
        delegate: Bookmark {}
    }
}
