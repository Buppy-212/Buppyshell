pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import qs.services

Scope {
    id: sliderWidget
    property bool visible: false
    enum Source {
        Volume,
        Mic,
        Brightness
    }
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
    LazyLoader {
        loading: sliderWidget.visible
        component: PanelWindow {
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "buppyshell:slider"
            exclusionMode: ExclusionMode.Ignore
            anchors.bottom: true
            margins.bottom: implicitHeight / 2
            visible: sliderWidget.visible
            color: "transparent"
            implicitHeight: Screen.height / 20
            implicitWidth: Screen.width / 10
            Rectangle {
                anchors.fill: parent
                color: Theme.color.black
                radius: Theme.radius.large
                height: parent.height
                width: parent.width * 0.8
                Row {
                    width: parent.width - Theme.margin.large
                    height: parent.height
                    spacing: Theme.margin.small
                    x: Theme.margin.medium
                    Text {
                        id: text
                        anchors.verticalCenter: parent.verticalCenter
                        text: {
                            switch (sliderWidget.source) {
                            case Sliders.Source.Volume:
                                return sliderWidget.muted || sliderWidget.input == 0 ? "volume_off" : "volume_up";
                                break;
                            case Sliders.Source.Mic:
                                return sliderWidget.micMuted || sliderWidget.input == 0 ? "mic_off" : "mic";
                                break;
                            case Sliders.Source.Brightness:
                                return "light_mode";
                                break;
                            }
                        }
                        font.family: Theme.font.family.material
                        font.pointSize: Theme.font.size.large
                        font.bold: true
                        color: Theme.color.fg
                    }
                    Slider {
                        id: slider
                        anchors.verticalCenter: parent.verticalCenter
                        live: false
                        height: text.height / 2
                        width: parent.width - text.width - Theme.margin.medium
                        from: 0
                        to: 100
                        value: sliderWidget.input
                        enabled: false
                        background: Rectangle {
                            width: slider.availableWidth
                            height: parent.height
                            color: Theme.color.grey
                            radius: Theme.radius.normal
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
                                radius: Theme.radius.normal
                            }
                        }
                    }
                }
            }
        }
    }
}
