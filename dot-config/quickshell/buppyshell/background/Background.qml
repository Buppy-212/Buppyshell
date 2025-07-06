import Quickshell
import QtQuick
import Quickshell.Wayland
import "../services/"

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property ShellScreen modelData
            screen: modelData
            WlrLayershell.layer: WlrLayer.Background
            WlrLayershell.namespace: "buppyshell:background"
            exclusionMode: ExclusionMode.Ignore
            color: "transparent"
            mask: Region {}
            anchors {
                top: true
                right: true
                left: true
                bottom: true
            }
            Image {
                id: image
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: Wallpaper.path
            }
            Date {}
        }
    }
}
