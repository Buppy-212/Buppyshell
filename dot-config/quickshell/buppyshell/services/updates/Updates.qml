pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property list<string> updates: fileView.text() === "" ? [] : fileView.text().trim().split("\n")

    FileView {
        id: fileView

        path: `${Quickshell.env("XDG_STATE_HOME")}/updates.txt`
        watchChanges: true
        onFileChanged: this.reload()
    }
}
