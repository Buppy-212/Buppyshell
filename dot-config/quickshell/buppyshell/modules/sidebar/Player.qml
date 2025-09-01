import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

Item {
    id: root

    property int currentIndex: 0

    implicitHeight: Theme.blockHeight * 5

    StyledButton {
        id: backButton

        implicitHeight: parent.height
        implicitWidth: root.width / 8
        anchors.left: parent.left
        text: ""
        font.pixelSize: Theme.font.size.doubled
        function tapped() {
            if (root.currentIndex > 0) {
                root.currentIndex -= 1;
            } else {
                (root.currentIndex = Mpris.players.values.length - 1);
            }
        }
    }

    ColumnLayout {
        spacing: height / 10
        anchors {
            top: parent.top
            right: forwardButton.left
            bottom: parent.bottom
            left: backButton.right
        }

        StyledText {
            text: Mpris.players.values[root.currentIndex]?.trackTitle ?? false ? Mpris.players.values[root.currentIndex].trackTitle : "No Track"
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height / 5
            font.pixelSize: Theme.font.size.doubled
            elide: Text.ElideRight
        }

        Row {
            id: playbackControls

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            spacing: Theme.blockHeight / 2

            Behavior on anchors.bottomMargin {
                animation: Theme.animation.elementMove.numberAnimation.createObject(this)
            }

            StyledButton {
                implicitHeight: parent.height
                implicitWidth: implicitHeight
                text: ""
                font.pixelSize: Theme.font.size.doubled
                function tapped() {
                    if (Mpris.players.values[root.currentIndex].canGoPrevious) {
                        Mpris.players.values[root.currentIndex].previous();
                    }
                }
            }

            StyledButton {
                implicitHeight: parent.height
                implicitWidth: implicitHeight
                text: Mpris.players.values[root.currentIndex]?.isPlaying ? "" : ""
                font.pixelSize: Theme.font.size.doubled
                function tapped(eventPoint, button) {
                    switch (button) {
                    case Qt.LeftButton:
                        Mpris.players.values[root.currentIndex].togglePlaying();
                        break;
                    case Qt.MiddleButton:
                        Mpris.players.values[root.currentIndex].stop();
                        break;
                    case Qt.RightButton:
                        Mpris.players.values[root.currentIndex].togglePlaying();
                        break;
                    }
                }
            }

            StyledButton {
                implicitHeight: parent.height
                implicitWidth: implicitHeight
                text: ""
                font.pixelSize: Theme.font.size.doubled
                function tapped() {
                    if (Mpris.players.values[root.currentIndex].canGoNext) {
                        Mpris.players.values[root.currentIndex].next();
                    }
                }
            }
        }
        StyledText {
            text: Mpris.players.values[root.currentIndex]?.trackAlbum ? `${Mpris.players.values[root.currentIndex]?.trackAlbum} - ${Mpris.players.values[root.currentIndex]?.trackArtist}` : Mpris.players.values[root.currentIndex]?.trackArtist ?? ""
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.15
            Layout.bottomMargin: parent.height / 20
            elide: Text.ElideMiddle
        }
    }
    StyledButton {
        id: forwardButton

        implicitHeight: parent.height
        implicitWidth: root.width / 8
        anchors.right: parent.right
        text: ""
        font.pixelSize: Theme.font.size.doubled
        function tapped() {
            if (root.currentIndex < Mpris.players.values.length - 1) {
                root.currentIndex += 1;
            } else {
                root.currentIndex = 0;
            }
        }
    }
}
