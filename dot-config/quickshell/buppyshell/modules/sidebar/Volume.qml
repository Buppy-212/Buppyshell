import Quickshell.Services.Pipewire
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.widgets

Rectangle {
    color: Theme.color.bg
    Rectangle {
        id: title
        anchors.top: parent.top
        implicitWidth: parent.width
        implicitHeight: Theme.height.doubleBlock
        color: Theme.color.bg
        radius: Theme.radius.normal
        StyledText {
            text: "Volume"
            font.pixelSize: Theme.font.size.doubled
        }
    }
    Rectangle {
        id: volumeWidget
        color: Theme.color.bgalt
        radius: Theme.radius.normal
        anchors {
            margins: 36
            topMargin: title.height
            fill: parent
        }
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
                        WrapperMouseArea {
                            cursorShape: Qt.PointingHandCursor
                            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                            anchors.horizontalCenter: parent.horizontalCenter
                            implicitHeight: parent.height / 2
                            implicitWidth: parent.width
                            StyledText {
                                text: sinkDelegate.modelData.description
                                elide: Text.ElideRight
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                            }
                            onClicked: Pipewire.preferredDefaultAudioSink = sinkDelegate.modelData
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
                            WrapperMouseArea {
                                cursorShape: Qt.PointingHandCursor
                                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                                Layout.fillHeight: true
                                Layout.preferredWidth: 36
                                StyledText {
                                    readonly property int volume: sinkSlider.value * 100
                                    text: sinkDelegate.modelData.audio?.muted ? "" : `${volume}%`
                                }
                                onClicked: sinkDelegate.modelData.audio.muted = !sinkDelegate.modelData.audio.muted
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
                        WrapperMouseArea {
                            cursorShape: Qt.PointingHandCursor
                            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                            anchors.horizontalCenter: parent.horizontalCenter
                            implicitHeight: parent.height / 2
                            implicitWidth: parent.width
                            StyledText {
                                text: sourceDelegate.modelData.description
                                elide: Text.ElideRight
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                            }
                            onClicked: Pipewire.preferredDefaultAudioSource = sourceDelegate.modelData
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
                            WrapperMouseArea {
                                cursorShape: Qt.PointingHandCursor
                                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                                Layout.fillHeight: true
                                Layout.preferredWidth: 36
                                StyledText {
                                    readonly property int volume: sourceSlider.value * 100
                                    text: sourceDelegate.modelData.audio?.muted ? "" : `${volume}%`
                                }
                                onClicked: sourceDelegate.modelData.audio.muted = !sourceDelegate.modelData.audio.muted
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
                        Item {
                            anchors.horizontalCenter: parent.horizontalCenter
                            implicitHeight: parent.height / 2
                            implicitWidth: parent.width
                            StyledText {
                                text: streamDelegate.modelData.name
                                elide: Text.ElideRight
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                            }
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
                            WrapperMouseArea {
                                cursorShape: Qt.PointingHandCursor
                                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                                Layout.fillHeight: true
                                Layout.preferredWidth: 36
                                StyledText {
                                    readonly property int volume: streamSlider.value * 100
                                    text: streamDelegate.modelData.audio?.muted ? "" : `${volume}%`
                                }
                                onClicked: streamDelegate.modelData.audio.muted = !streamDelegate.modelData.audio.muted
                            }
                        }
                    }
                }
            }
        }
    }
}
