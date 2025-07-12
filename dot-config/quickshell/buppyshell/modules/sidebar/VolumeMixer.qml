import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import "../../services"
import "../../widgets"

Rectangle {
    color: Theme.color.bg
    anchors.fill: parent
    Rectangle {
        id: title
        anchors.top: parent.top
        implicitWidth: parent.width
        implicitHeight: 48
        color: Theme.color.bg
        radius: Theme.rounding
        StyledText {
            text: "Volume"
            font.pointSize: 26
        }
    }
    Rectangle {
        id: volumeWidget
        color: Theme.color.bgalt
        radius: Theme.rounding
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
                    id: delegate
                    required property PwNode modelData
                    visible: modelData.isSink && modelData.audio && modelData.description
                    implicitWidth: parent.width
                    implicitHeight: 48
                    PwObjectTracker {
                        objects: [delegate.visible ? delegate.modelData : null]
                    }
                    Column {
                        width: parent.width
                        Item {
                            anchors.horizontalCenter: parent.horizontalCenter
                            implicitHeight: 24
                            implicitWidth: row.width
                            StyledText {
                                text: delegate.modelData.description
                                elide: Text.ElideRight
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        Row {
                            id: row
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 24
                            spacing: 12
                            Slider {
                                id: slider
                                live: false
                                height: parent.height
                                width: 400
                                snapMode: Slider.SnapOnRelease
                                stepSize: 0.05
                                from: 0
                                to: 1
                                value: delegate.modelData.audio?.volume ?? 0
                                onValueChanged: delegate.modelData.audio.volume = value
                                wheelEnabled: true
                                HoverHandler {
                                  cursorShape: Qt.PointingHandCursor
                                }
                                background: Rectangle {
                                    width: slider.availableWidth
                                    height: parent.height
                                    color: Theme.color.grey
                                    radius: Theme.rounding
                                    Rectangle {
                                        width: slider.visualPosition * parent.width
                                        height: parent.height
                                        color: modelData == Pipewire.defaultAudioSink ? Theme.color.red : Theme.color.blue
                                        radius: Theme.rounding
                                    }
                                }
                            }
                            Item {
                                implicitHeight: parent.height
                                implicitWidth: 36
                                StyledText {
                                    readonly property int volume: slider.value * 100
                                    text: `${volume}%`
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
                    implicitHeight: 48
                    PwObjectTracker {
                        objects: [streamDelegate.visible ? streamDelegate.modelData : null]
                    }
                    Column {
                        width: parent.width
                        Item {
                            anchors.horizontalCenter: parent.horizontalCenter
                            implicitHeight: 24
                            implicitWidth: streamRow.width
                            StyledText {
                                text: streamDelegate.modelData.name
                                elide: Text.ElideRight
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        Row {
                            id: streamRow
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 24
                            spacing: 12
                            Slider {
                                id: streamSlider
                                live: false
                                height: parent.height
                                width: 400
                                snapMode: Slider.SnapOnRelease
                                stepSize: 0.05
                                from: 0
                                to: 1
                                value: streamDelegate.modelData.audio?.volume ?? 0
                                onValueChanged: streamDelegate.modelData.audio.volume = value
                                wheelEnabled: true
                                HoverHandler {
                                  cursorShape: Qt.PointingHandCursor
                                }
                                background: Rectangle {
                                    width: streamSlider.availableWidth
                                    height: parent.height
                                    color: Theme.color.grey
                                    radius: Theme.rounding
                                    Rectangle {
                                        width: streamSlider.visualPosition * parent.width
                                        height: parent.height
                                        color: Theme.color.blue
                                        radius: Theme.rounding
                                    }
                                }
                            }
                            Item {
                                implicitHeight: parent.height
                                implicitWidth: 36
                                StyledText {
                                    readonly property int volume: streamSlider.value * 100
                                    text: `${volume}%`
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
