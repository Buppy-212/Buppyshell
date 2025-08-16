pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
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
        case Sliders.Source.Volume:
            return volume;
            break;
        case Sliders.Source.Mic:
            return mic;
            break;
        case Sliders.Source.Brightness:
            return brightness;
            break;
        }
    }
    onBrightnessChanged: {
        ready = true;
        source = Sliders.Source.Brightness;
        timer.restart();
    }
    onVolumeChanged: {
        ready = true;
        source = Sliders.Source.Volume;
        timer.restart();
    }
    onMutedChanged: {
        ready = true;
        source = Sliders.Source.Volume;
        timer.restart();
    }
    onMicChanged: {
        ready = true;
        source = Sliders.Source.Mic;
        timer.restart();
    }
    onMicMutedChanged: {
        ready = true;
        source = Sliders.Source.Mic;
        timer.restart();
    }
    screen: modelData
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "buppyshell:slider"
    exclusionMode: ExclusionMode.Ignore
    anchors.bottom: true
    margins.bottom: screen.height / 50
    visible: root.ready && modelData.name === Hyprland.focusedMonitor?.name
    color: "transparent"
    implicitHeight: screen.height / 10
    implicitWidth: screen.width / 10
    Timer {
        id: timer
        interval: 2000
        running: root.ready
        onTriggered: root.ready = false
    }
    Rectangle {
        anchors.fill: parent
        color: Theme.color.bgTranslucent
        radius: height / 3
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
                    case Sliders.Source.Volume:
                        return root.muted || root.input === 0 ? "" : "";
                        break;
                    case Sliders.Source.Mic:
                        return root.micMuted || root.input === 0 ? "" : "";
                        break;
                    case Sliders.Source.Brightness:
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
                    case Sliders.Source.Volume:
                        return Theme.color.blue;
                        break;
                    case Sliders.Source.Mic:
                        return Theme.color.magenta;
                        break;
                    case Sliders.Source.Brightness:
                        return Theme.color.yellow;
                        break;
                    }
                }
            }
        }
    }
}
