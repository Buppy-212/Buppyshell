pragma ComponentBehavior: Bound

import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

ColumnLayout {
    id: root

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
            listView.currentItem.mute();
            break;
        case Qt.Key_Return:
            listView.currentItem.tapped();
            break;
        }
    }

    Header {
        Layout.fillWidth: true
        title: "Volume"
    }

    StyledListView {
        id: listView

        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.rightMargin: root.width / 16
        Layout.leftMargin: root.width / 16
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
        delegate: StyledButton {
            id: delegate

            required property PwNode modelData
            required property int index

            function mute(): void {
                delegate.modelData.audio.muted = !delegate.modelData.audio.muted;
            }
            function increase(): void {
                slider.increase();
                slider.moved();
            }
            function decrease(): void {
                slider.decrease();
                slider.moved();
            }
            function entered(): void {
                listView.currentIndex = delegate.index;
            }
            function tapped(eventPoint, button): void {
                switch (button) {
                case Qt.LeftButton:
                    if (delegate.modelData.isSink) {
                        Pipewire.preferredDefaultAudioSink = delegate.modelData;
                    } else if (!delegate.modelData.isStream) {
                        Pipewire.preferredDefaultAudioSource = delegate.modelData;
                    }
                    break;
                default:
                    delegate.mute();
                }
            }

            background: null
            accentColor: Theme.color.accent
            visible: delegate.modelData?.ready ?? false
            implicitWidth: listView.width
            implicitHeight: Theme.blockHeight * 3
            contentItem: ColumnLayout {
                spacing: Theme.spacing

                StyledText {
                    text: delegate.modelData.isStream ? delegate.modelData.name : delegate.modelData.description
                    color: delegate.ListView.isCurrentItem ? delegate.accentColor : delegate.buttonColor
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                    Layout.preferredHeight: Theme.blockHeight
                }

                RowLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.bottomMargin: Theme.spacing
                    spacing: 0

                    StyledSlider {
                        id: slider

                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        value: delegate.modelData.audio?.volume ?? 0
                        onMoved: delegate.modelData.ready ? delegate.modelData.audio.volume = value : undefined
                        wheelEnabled: true
                        color: {
                            var col = Theme.color.magenta;
                            if (delegate.modelData.isSink) {
                                col = Theme.color.blue;
                            }
                            if (delegate.modelData !== Pipewire.defaultAudioSink && delegate.modelData !== Pipewire.defaultAudioSource) {
                                col = Qt.darker(col);
                            }
                            if (delegate.modelData.isStream) {
                                col = Theme.color.red;
                            }
                            return col;
                        }
                        handle: Rectangle {
                            id: button

                            anchors {
                                top: parent.top
                                bottom: parent.bottom
                                right: parent.right
                                margins: Theme.border
                            }
                            color: Theme.color.black
                            implicitWidth: Theme.blockWidth * 1.5
                            radius: height / 2

                            StyledText {
                                id: text

                                anchors.fill: parent
                                color: slider.color
                                text: {
                                    var volume = Math.trunc(delegate.modelData.audio.volume * 100);
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
                            }
                        }
                    }
                }
            }
        }
    }
}
