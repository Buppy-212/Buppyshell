import Quickshell
import QtQuick
import Quickshell.Wayland
import qs.services
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
        cache: false
        fillMode: Image.PreserveAspectCrop
        source: Wallpapers.current
    }

    Date {}
}
