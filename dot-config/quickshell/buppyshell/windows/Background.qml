import Quickshell
import QtQuick
import QtQuick.Effects
import Quickshell.Wayland
import qs.services
import qs.widgets
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

    GlassBackground {
        id: background

        anchors.fill: parent
    }

    ShaderEffectSource {
        id: effectSource

        sourceItem: background
        anchors.fill: date
        sourceRect: Qt.rect(x, y, width, height)
        visible: false
    }

    Date {
        id: date
        MultiEffect {
            anchors.fill: parent
            z: -1
            source: effectSource
            autoPaddingEnabled: false
            blur: 1
            blurMultiplier: 2
            blurMax: 48
            blurEnabled: true
        }
    }
}
