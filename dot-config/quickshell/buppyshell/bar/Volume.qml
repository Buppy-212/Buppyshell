pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import Quickshell.Services.Pipewire
import "../services"

ClippingRectangle {
    id: volumeWidget
    property bool revealed: false
    implicitWidth: Theme.blockWidth
    implicitHeight: revealed ? column.size * 26 + 24 : 24
    color: "transparent"
    Behavior on implicitHeight {
        animation: Theme.animation.elementMoveFast.numberAnimation.createObject(this)
    }
    onRevealedChanged: column.size = 0
    Column {
        id: column
        anchors.fill: parent
        spacing: 2
        property int size: 0
        Block {
            id: mainVolume
            readonly property int volume: Pipewire.defaultAudioSink?.audio.volume * 100
            readonly property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? false
            hovered: mouse.containsMouse
            PwObjectTracker {
                objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
            }
            StyledText {
                text: mainVolume.muted || mainVolume.volume == 0 ? "" : mainVolume.volume == 100 ? "" : mainVolume.volume
                color: Theme.color.blue
            }
            MouseBlock {
                id: mouse
                onEntered: GlobalState.overrideTitle("Volume")
                onExited: GlobalState.refreshTitle()
                onClicked: mouse => {
                    if (mouse.button == Qt.MiddleButton) {
                        Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted;
                    } else if (mouse.button == Qt.RightButton) {
                        volumeWidget.revealed = !volumeWidget.revealed;
                    } else {
                        Quickshell.execDetached(["uwsm", "app", "--", "floatty", "pulsemixer"]);
                    }
                }
                onWheel: wheel => {
                    if (wheel.angleDelta.y > 0) {
                        if (mainVolume.volume <= 95) {
                            Pipewire.defaultAudioSink.audio.volume += 0.05;
                        } else {
                            Pipewire.defaultAudioSink.audio.volume = 1;
                        }
                    } else {
                        Pipewire.defaultAudioSink.audio.volume -= 0.05;
                    }
                }
            }
        }
        Repeater {
            id: rep
            model: Pipewire.nodes
            delegate: Block {
                id: streamBlock
                required property PwNode modelData
                readonly property int volume: modelData.audio?.volume * 100
                readonly property bool muted: modelData.audio?.muted ?? false
                hovered: streamMouse.containsMouse
                visible: modelData.isStream && volumeWidget.revealed
                onVisibleChanged: column.size += 1
                PwObjectTracker {
                    objects: [streamBlock.modelData]
                }
                StyledText {
                    text: streamBlock.muted || streamBlock.volume == 0 ? "" : streamBlock.volume == 100 ? "" : streamBlock.volume
                    color: Theme.color.blue
                }
                MouseBlock {
                    id: streamMouse
                    onEntered: GlobalState.overrideTitle(modelData.name)
                    onExited: GlobalState.refreshTitle()
                    onClicked: mouse => {
                        if (mouse.button == Qt.MiddleButton) {
                            modelData.audio.muted = !modelData.audio.muted;
                        } else if (mouse.button == Qt.RightButton) {
                            volumeWidget.revealed = !volumeWidget.revealed;
                        } else {
                            Quickshell.execDetached(["uwsm", "app", "--", "floatty", "pulsemixer"]);
                        }
                    }
                    onWheel: wheel => {
                        if (wheel.angleDelta.y > 0) {
                            if (streamBlock.volume <= 95) {
                                modelData.audio.volume += 0.05;
                            } else {
                                modelData.audio.volume = 1;
                            }
                        } else {
                            modelData.audio.volume -= 0.05;
                        }
                    }
                }
            }
        }
    }
}
