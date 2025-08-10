pragma ComponentBehavior: Bound

import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

ColumnLayout {
    spacing: 0
    Keys.forwardTo: [listView]
    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_Left:
            listView.currentItem.decrease();
            break;
        case Qt.Key_Right:
            listView.currentItem.increase();
            break;
        case Qt.Key_H:
            listView.currentItem.decrease();
            break;
        case Qt.Key_L:
            listView.currentItem.increase();
            break;
        case Qt.Key_M:
            listView.currentItem.increase();
            break;
        case Qt.Key_Return:
            listView.currentItem.makeDefault();
            break;
        }
    }
    Header {
        Layout.fillWidth: true
        Layout.preferredHeight: Theme.height.doubleBlock
        title: "Volume"
    }
    StyledListView {
        id: listView
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.bottomMargin: 36
        Layout.rightMargin: 36
        Layout.leftMargin: 36
        model: Pipewire.nodes.values.filter(a => a.audio).sort((a, b) => {
            let score = (b.isSink - a.isSink) + 2 * (a.isStream - b.isStream);
            if (a.score === b.score) {
                if (a.description && b.description) {
                    score += a.description.localeCompare(b.description) / 16;
                } else {
                    score += a.name.localeCompare(b.name) / 16;
                }
            }
            return score;
        })
        delegate: Item {
            id: delegate
            required property PwNode modelData
            function mute(): void {
                delegate.modelData.audio.muted = !delegate.modelData.audio.muted;
            }
            function makeDefault(): void {
                if (delegate.modelData.isSink) {
                    Pipewire.preferredDefaultAudioSink = delegate.modelData;
                } else if (!delegate.modelData.isStream) {
                    Pipewire.preferredDefaultAudioSource = delegate.modelData;
                }
            }
            function increase(): void {
                slider.increase();
                slider.moved();
            }
            function decrease(): void {
                slider.decrease();
                slider.moved();
            }
            implicitWidth: listView.width
            implicitHeight: 72
            ColumnLayout {
                spacing: 4
                anchors {
                    fill: parent
                    margins: 12
                }
                StyledButton {
                    text: delegate.modelData.isStream ? delegate.modelData.name : delegate.modelData.description
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height / 3
                    background: null
                    function tapped(): void {
                        delegate.makeDefault();
                    }
                }
                RowLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    spacing: 0
                    StyledSlider {
                        id: slider
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        value: delegate.modelData.audio?.volume ?? 0
                        onMoved: delegate.modelData.ready ? delegate.modelData.audio.volume = value : undefined
                        wheelEnabled: true
                        HoverHandler {
                            cursorShape: Qt.PointingHandCursor
                        }
                        color: {
                            var col = Theme.color.magenta;
                            if (delegate.modelData.isSink) {
                                col = Theme.color.blue;
                            }
                            if (delegate.modelData != Pipewire.defaultAudioSink && delegate.modelData != Pipewire.defaultAudioSource) {
                                col = Qt.darker(col);
                            }
                            if (delegate.modelData.isStream) {
                                col = Theme.color.red;
                            }
                            return col;
                        }
                    }
                    StyledButton {
                        id: button
                        Layout.fillHeight: true
                        Layout.preferredWidth: 40
                        text: {
                            var volume = Math.round(delegate.modelData.audio.volume * 100);
                            if (!delegate.modelData.isSink && !delegate.modelData.isStream) {
                                if (delegate.modelData.audio?.muted ?? true) {
                                    volume = "";
                                }
                            } else {
                                if (delegate.modelData.audio?.muted ?? true) {
                                    volume = "";
                                }
                            }
                            return volume;
                        }
                        color: slider.color
                        background: null
                        function tapped(): void {
                            delegate.mute();
                        }
                    }
                }
            }
        }
    }
}
