pragma Singleton
pragma ComponentBehavior: Bound

import qs.utils
import QtQuick
import Quickshell
import Quickshell.Io

Searcher {
    id: root

    property list<QtObject> bookmarks

    key: "name"
    list: bookmarks

    Process {
        id: get

        command: ["cat", `${Quickshell.env("XDG_STATE_HOME")}/bookmarks.txt`]
        running: true
        stdout: SplitParser {
            onRead: data => {
                var newObject = Qt.createQmlObject(`
                  import QtQuick
                  QtObject {
                    property string name
                  }`, root);
                newObject.name = data;
                root.bookmarks.push(newObject);
            }
        }
    }
}
