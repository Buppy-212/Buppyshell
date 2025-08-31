import Quickshell
import QtQml

QtObject {
    required property string modelData
    readonly property string name: modelData

    function open(): void {
        Quickshell.execDetached(["uwsm", "app", "--", "zen-browser", name]);
    }
    function openInNewWindow(): void {
        Quickshell.execDetached(["uwsm", "app", "--", "zen-browser", "-new-window", name]);
    }
}
