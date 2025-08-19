import Quickshell
import QtQml

QtObject {
    required property string modelData
    readonly property string name: modelData

    function open(): void {
        Quickshell.execDetached(["uwsm", "app", "--", "zen-browser", name])
    }
    function edit(): void {
        Quickshell.execDetached(["uwsm", "app", "--", "floatty", "nvim", `${Quickshell.env("XDG_STATE_HOME")}/bookmarks.txt`]);
    }
    function openInNewWindow(): void {
        Quickshell.execDetached(["uwsm", "app", "--", "zen-browser", "-new-window", name])
    }
}
