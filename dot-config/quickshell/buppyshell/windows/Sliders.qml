pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import qs.services
import qs.widgets

Scope {
    id: sliderWidget
    enum Source {
        Volume,
        Mic,
        Brightness
    }
    property bool visible: false
    required property int source
    readonly property int brightness: Brightness.brightness
    readonly property int volume: Pipewire.defaultAudioSink?.audio.volume * 100
    readonly property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? false
    readonly property int mic: Pipewire.defaultAudioSource?.audio.volume * 100
    readonly property bool micMuted: Pipewire.defaultAudioSource?.audio.muted ?? false
    readonly property int input: {
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
        visible = true;
        source = Sliders.Source.Brightness;
        timer.restart();
    }
    onVolumeChanged: {
        visible = true;
        source = Sliders.Source.Volume;
        timer.restart();
    }
    onMutedChanged: {
        visible = true;
        source = Sliders.Source.Volume;
        timer.restart();
    }
    onMicChanged: {
        visible = true;
        source = Sliders.Source.Mic;
        timer.restart();
    }
    onMicMutedChanged: {
        visible = true;
        source = Sliders.Source.Mic;
        timer.restart();
    }
    Timer {
        id: timer
        interval: 2000
        running: sliderWidget.visible
        onTriggered: sliderWidget.visible = !sliderWidget.visible
    }
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property ShellScreen modelData
            screen: modelData
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "buppyshell:slider"
            exclusionMode: ExclusionMode.Ignore
            anchors.bottom: true
            margins.bottom: screen.height / 50
            visible: sliderWidget.visible && modelData.name === Hyprland.focusedMonitor?.name
            color: "transparent"
            implicitHeight: screen.height / 10
            implicitWidth: screen.width / 10
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
                    Item {
                        width: parent.width
                        height: parent.height / 2
                        StyledText {
                            text: {
                                switch (sliderWidget.source) {
                                case Sliders.Source.Volume:
                                    return sliderWidget.muted || sliderWidget.input == 0 ? "" : "";
                                    break;
                                case Sliders.Source.Mic:
                                    return sliderWidget.micMuted || sliderWidget.input == 0 ? "" : "";
                                    break;
                                case Sliders.Source.Brightness:
                                    return "";
                                    break;
                                }
                            }
                            font.pixelSize: height
                        }
                    }
                    Slider {
                        id: slider
                        live: false
                        width: parent.width
                        height: parent.height / 8
                        from: 0
                        to: 100
                        value: sliderWidget.input
                        enabled: false
                        background: ClippingRectangle {
                            color: Theme.color.grey
                            radius: height
                            Rectangle {
                                width: slider.visualPosition * parent.width
                                height: parent.height
                                color: {
                                    switch (sliderWidget.source) {
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
                                radius: height
                            }
                        }
                    }
                }
            }
        }
    }
}
