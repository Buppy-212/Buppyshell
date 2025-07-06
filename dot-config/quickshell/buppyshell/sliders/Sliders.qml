pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import "../services"

Scope {
    id: sliderWidget
    property bool visible: false
    required property bool isVolume
    required property bool isMic
    readonly property int brightness: Brightness.brightness
    readonly property int volume: Pipewire.defaultAudioSink?.audio.volume * 100
    readonly property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? false
    readonly property int mic: Pipewire.defaultAudioSource?.audio.volume * 100
    readonly property bool micMuted: Pipewire.defaultAudioSource?.audio.muted ?? false
    readonly property int input: isVolume ? volume : isMic ? mic : brightness
    onBrightnessChanged: {
        visible = true;
        isVolume = false;
        isMic = false;
        timer.restart();
    }
    onVolumeChanged: {
        visible = true;
        isVolume = true;
        isMic = false;
        timer.restart();
    }
    onMutedChanged: {
        visible = true;
        isVolume = true;
        isMic = false;
        timer.restart();
    }
    onMicChanged: {
        visible = true;
        isVolume = false;
        isMic = true;
        timer.restart();
    }
    onMicMutedChanged: {
        visible = true;
        isVolume = false;
        isMic = true;
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
                radius: Theme.rounding * 4
                height: parent.height
                width: parent.width * 0.8
                Row {
                    anchors.fill: parent
                    anchors.leftMargin: text.width - Theme.border * 2
                    spacing: Theme.border
                    Text {
                        id: text
                        anchors.verticalCenter: parent.verticalCenter
                        text: sliderWidget.isVolume ? sliderWidget.muted || sliderWidget.input == 0 ? "volume_off" : "volume_up" : sliderWidget.isMic ? sliderWidget.micMuted || sliderWidget.input == 0 ? "mic_off" : "mic" : "light_mode"
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
                        width: parent.width - text.width * 2
                        from: 0
                        to: 100
                        value: sliderWidget.input
                        background: Rectangle {
                            width: slider.availableWidth
                            height: parent.height
                            color: Theme.color.grey
                            radius: Theme.rounding
                            Rectangle {
                                width: slider.visualPosition * parent.width
                                height: parent.height
                                color: sliderWidget.isVolume ? Theme.color.blue : sliderWidget.isMic ? Theme.color.magenta : Theme.color.yellow
                                radius: Theme.rounding
                            }
                        }
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
            }
        }
    }
}
