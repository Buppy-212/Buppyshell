pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import qs.services
import qs.widgets

PanelWindow {
    id: root

    enum Source {
        Volume,
        Mic,
        Brightness
    }

    required property ShellScreen modelData
    required property int source
    property bool ready: false
    readonly property real brightness: Brightness.brightness
    readonly property real volume: Pipewire.defaultAudioSink?.audio.volume ?? 0
    readonly property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? false
    readonly property real mic: Pipewire.defaultAudioSource?.audio.volume ?? 0
    readonly property bool micMuted: Pipewire.defaultAudioSource?.audio.muted ?? false
    readonly property real input: {
        switch (source) {
        case Osd.Volume:
            return volume;
            break;
        case Osd.Mic:
            return mic;
            break;
        case Osd.Brightness:
            return brightness;
            break;
        }
    }

    onBrightnessChanged: {
        ready = true;
        source = Osd.Brightness;
        timer.restart();
    }
    onVolumeChanged: {
        ready = true;
        source = Osd.Volume;
        timer.restart();
    }
    onMutedChanged: {
        ready = true;
        source = Osd.Volume;
        timer.restart();
    }
    onMicChanged: {
        ready = true;
        source = Osd.Mic;
        timer.restart();
    }
    onMicMutedChanged: {
        ready = true;
        source = Osd.Mic;
        timer.restart();
    }

    screen: modelData
    anchors.bottom: true
    margins.bottom: screen.height / 50
    implicitHeight: screen.height / 10
    implicitWidth: screen.width / 10
    visible: root.ready && modelData.name === Hyprland.focusedMonitor?.name
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    mask: Region {}
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "buppyshell:osd"

    Timer {
        id: timer
        interval: 2000
        running: root.ready
        onTriggered: root.ready = false
    }

    ClippingRectangle {
        id: osd

        anchors.fill: parent
        color: "transparent"
        radius: height / 3

        GlassBackground {
            id: background

            anchors.fill: parent
            sourceSize: Qt.size(root.screen.width, root.screen.height)
            sourceClipRect: Qt.rect(root.screen.width / 2 - osd.width / 2, root.screen.height - osd.height - root.margins.bottom, osd.width, osd.height)
        }

        MultiEffect {
            anchors.fill: parent
            source: background
            autoPaddingEnabled: false
            blur: 1
            blurMultiplier: 2
            blurMax: 24
            blurEnabled: true
        }

        Column {
            anchors {
                fill: parent
                leftMargin: parent.width / 8
                rightMargin: parent.width / 8
            }
            topPadding: spacing
            spacing: parent.height / 8

            StyledText {
                text: {
                    switch (root.source) {
                    case Osd.Volume:
                        return root.muted || root.input === 0 ? "" : "";
                        break;
                    case Osd.Mic:
                        return root.micMuted || root.input === 0 ? "" : "";
                        break;
                    case Osd.Brightness:
                        return "";
                        break;
                    }
                }
                width: parent.width
                height: parent.height / 2
                font.pixelSize: height
            }

            StyledSlider {
                width: parent.width
                height: parent.height / 8
                value: root.input
                live: false
                enabled: false
                color: {
                    switch (root.source) {
                    case Osd.Volume:
                        return Theme.color.blue;
                        break;
                    case Osd.Mic:
                        return Theme.color.magenta;
                        break;
                    case Osd.Brightness:
                        return Theme.color.yellow;
                        break;
                    }
                }
            }
        }
    }
}
