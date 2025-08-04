import Quickshell.Services.Pipewire
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.widgets

GridLayout {
    columns: 1
    rows: 2
    columnSpacing: 0
    rowSpacing: 0
    StyledText {
        id: title
        text: "Volume"
        Layout.fillWidth: true
        Layout.preferredHeight: Theme.height.doubleBlock
        font.pixelSize: Theme.font.size.doubled
    }
    Rectangle {
        id: volumeWidget
        color: Theme.color.bgalt
        radius: Theme.radius.normal
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.rightMargin: 36
        Layout.bottomMargin: 36
        Layout.leftMargin: 36
        MouseArea {
            anchors.fill: parent
        }
        Column {
            spacing: 24
            anchors {
                fill: parent
                margins: 12
            }
            Repeater {
                model: Pipewire.nodes
                delegate: Item {
                    id: sinkDelegate
                    required property PwNode modelData
                    visible: modelData.isSink && modelData.audio && !modelData.isStream
                    implicitWidth: parent.width
                    implicitHeight: Theme.height.doubleBlock
                    PwObjectTracker {
                        objects: [sinkDelegate.visible ? sinkDelegate.modelData : null]
                    }
                    Column {
                        width: parent.width
                        height: Theme.height.doubleBlock
                        StyledText {
                            text: sinkDelegate.modelData.description
                            elide: Text.ElideRight
                            width: parent.width
                            height: parent.height / 2
                            horizontalAlignment: Text.AlignHCenter
                            MouseBlock {
                                onClicked: Pipewire.preferredDefaultAudioSink = sinkDelegate.modelData
                            }
                        }
                        RowLayout {
                            width: parent.width
                            height: parent.height / 2
                            spacing: 12
                            Slider {
                                id: sinkSlider
                                live: false
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                snapMode: Slider.SnapOnRelease
                                stepSize: 0.05
                                from: 0
                                to: 1
                                value: sinkDelegate.modelData.audio?.volume ?? 0
                                onValueChanged: sinkDelegate.modelData.ready ? sinkDelegate.modelData.audio.volume = value : undefined
                                wheelEnabled: true
                                HoverHandler {
                                    cursorShape: Qt.PointingHandCursor
                                }
                                background: ClippingRectangle {
                                    width: sinkSlider.availableWidth
                                    height: parent.height
                                    color: Theme.color.grey
                                    radius: Theme.radius.normal
                                    Rectangle {
                                        width: sinkSlider.visualPosition * parent.width
                                        height: parent.height
                                        color: Theme.color.blue
                                        opacity: sinkDelegate.modelData == Pipewire.defaultAudioSink ? 1 : 0.25
                                        radius: Theme.radius.normal
                                    }
                                }
                            }
                            StyledText {
                                readonly property int volume: sinkSlider.value * 100
                                Layout.fillHeight: true
                                Layout.preferredWidth: 36
                                text: sinkDelegate.modelData.audio?.muted ? "" : `${volume}%`
                                MouseBlock {
                                    onClicked: sinkDelegate.modelData.audio.muted = !sinkDelegate.modelData.audio.muted
                                }
                            }
                        }
                    }
                }
            }
            Rectangle {
                implicitHeight: 2
                implicitWidth: parent.width
                color: Theme.color.black
            }
            Repeater {
                model: Pipewire.nodes
                delegate: Item {
                    id: sourceDelegate
                    required property PwNode modelData
                    visible: modelData.audio && !modelData.isStream && !modelData.isSink
                    implicitWidth: parent.width
                    implicitHeight: Theme.height.doubleBlock
                    PwObjectTracker {
                        objects: [sourceDelegate.visible ? sourceDelegate.modelData : null]
                    }
                    Column {
                        width: parent.width
                        height: Theme.height.doubleBlock
                        StyledText {
                            text: sourceDelegate.modelData.description
                            elide: Text.ElideRight
                            width: parent.width
                            height: parent.height / 2
                            horizontalAlignment: Text.AlignHCenter
                            MouseBlock {
                                onClicked: Pipewire.preferredDefaultAudioSource = sourceDelegate.modelData
                            }
                        }
                        RowLayout {
                            width: parent.width
                            height: parent.height / 2
                            spacing: 12
                            Slider {
                                id: sourceSlider
                                live: false
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                snapMode: Slider.SnapOnRelease
                                stepSize: 0.05
                                from: 0
                                to: 1
                                value: sourceDelegate.modelData.audio?.volume ?? 0
                                onValueChanged: sourceDelegate.modelData.ready ? sourceDelegate.modelData.audio.volume = value : undefined
                                wheelEnabled: true
                                HoverHandler {
                                    cursorShape: Qt.PointingHandCursor
                                }
                                background: ClippingRectangle {
                                    width: sourceSlider.availableWidth
                                    height: parent.height
                                    color: Theme.color.grey
                                    radius: Theme.radius.normal
                                    Rectangle {
                                        width: sourceSlider.visualPosition * parent.width
                                        height: parent.height
                                        color: Theme.color.magenta
                                        opacity: sourceDelegate.modelData == Pipewire.defaultAudioSource ? 1 : 0.25
                                        radius: Theme.radius.normal
                                    }
                                }
                            }
                            StyledText {
                                readonly property int volume: sourceSlider.value * 100
                                Layout.fillHeight: true
                                Layout.preferredWidth: 36
                                text: sourceDelegate.modelData.audio?.muted ? "" : `${volume}%`
                                MouseBlock {
                                    onClicked: sourceDelegate.modelData.audio.muted = !sourceDelegate.modelData.audio.muted
                                }
                            }
                        }
                    }
                }
            }
            Rectangle {
                implicitHeight: 2
                implicitWidth: parent.width
                color: Theme.color.black
            }
            Repeater {
                model: Pipewire.nodes
                delegate: Item {
                    id: streamDelegate
                    required property PwNode modelData
                    visible: modelData.isStream && modelData.audio
                    implicitWidth: parent.width
                    implicitHeight: Theme.height.doubleBlock
                    PwObjectTracker {
                        objects: [streamDelegate.visible ? streamDelegate.modelData : null]
                    }
                    Column {
                        width: parent.width
                        height: Theme.height.doubleBlock
                        StyledText {
                            text: streamDelegate.modelData.name
                            elide: Text.ElideRight
                            height: parent.height / 2
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                        RowLayout {
                            width: parent.width
                            height: parent.height / 2
                            spacing: 12
                            Slider {
                                id: streamSlider
                                live: false
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                snapMode: Slider.SnapOnRelease
                                stepSize: 0.05
                                from: 0
                                to: 1
                                value: streamDelegate.modelData.audio?.volume ?? 0
                                onValueChanged: streamDelegate.modelData.ready ? streamDelegate.modelData.audio.volume = value : undefined
                                wheelEnabled: true
                                HoverHandler {
                                    cursorShape: Qt.PointingHandCursor
                                }
                                background: ClippingRectangle {
                                    width: streamSlider.availableWidth
                                    height: parent.height
                                    color: Theme.color.grey
                                    radius: Theme.radius.normal
                                    Rectangle {
                                        width: streamSlider.visualPosition * parent.width
                                        height: parent.height
                                        color: Theme.color.red
                                        radius: Theme.radius.normal
                                    }
                                }
                            }
                            StyledText {
                                readonly property int volume: streamSlider.value * 100
                                Layout.fillHeight: true
                                Layout.preferredWidth: 36
                                text: streamDelegate.modelData.audio?.muted ? "" : `${volume}%`
                                MouseBlock {
                                    onClicked: streamDelegate.modelData.audio.muted = !streamDelegate.modelData.audio.muted
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
