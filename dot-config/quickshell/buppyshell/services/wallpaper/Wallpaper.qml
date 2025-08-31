import QtQml
import Quickshell

QtObject {
    required property string modelData
    readonly property url url: modelData
    readonly property string name: modelData.split("/").slice(-1).toString().split(".")[0]

    function select(): void {
        Wallpapers.current = url;
        Quickshell.execDetached(["ln", "-sf", url, `${Quickshell.env("XDG_STATE_HOME")}/buppyshell/wallpaper`]);
    }

    function greeter(): void {
        Quickshell.execDetached(["pkexec", "cp", url, "/usr/share/backgrounds/wallpaper"]);
    }
}
