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
        text: "Volume"
        Layout.fillWidth: true
        Layout.preferredHeight: Theme.height.doubleBlock
        font.pixelSize: Theme.font.size.doubled
    }
    Rectangle {
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
                            StyledSlider {
                                id: sinkSlider
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                value: sinkDelegate.modelData.audio?.volume ?? 0
                                onValueChanged: sinkDelegate.modelData.ready ? sinkDelegate.modelData.audio.volume = value : undefined
                                wheelEnabled: true
                                HoverHandler {
                                    cursorShape: Qt.PointingHandCursor
                                }
                                backgroundOpacity: sinkDelegate.modelData == Pipewire.defaultAudioSink ? 1 : 0.25
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
                            StyledSlider {
                                id: sourceSlider
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                value: sourceDelegate.modelData.audio?.volume ?? 0
                                onValueChanged: sourceDelegate.modelData.ready ? sourceDelegate.modelData.audio.volume = value : undefined
                                wheelEnabled: true
                                HoverHandler {
                                    cursorShape: Qt.PointingHandCursor
                                }
                                backgroundOpacity: sourceDelegate.modelData == Pipewire.defaultAudioSource ? 1 : 0.25
                                color: Theme.color.magenta
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
                            StyledSlider {
                                id: streamSlider
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                value: streamDelegate.modelData.audio?.volume ?? 0
                                onValueChanged: streamDelegate.modelData.ready ? streamDelegate.modelData.audio.volume = value : undefined
                                wheelEnabled: true
                                HoverHandler {
                                    cursorShape: Qt.PointingHandCursor
                                }
                                        color: Theme.color.red
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
