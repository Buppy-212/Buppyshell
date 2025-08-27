import Quickshell
import QtQuick
import Quickshell.Wayland
import qs.services.wallpaper
import qs.modules.background

PanelWindow {
    required property ShellScreen modelData

    screen: modelData
    anchors {
        top: true
        right: true
        left: true
        bottom: true
    }
    color: Theme.color.black
    mask: Region {}
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.namespace: "buppyshell:background"

    Image {
        anchors.fill: parent
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
        source: Wallpapers.current
    }

    Date {
        height: parent.height > parent.width ? parent.width / 3 : parent.height / 3
        width: height * 2
    }
}
