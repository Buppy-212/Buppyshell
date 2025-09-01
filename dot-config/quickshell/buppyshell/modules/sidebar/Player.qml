import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

Item {
    implicitHeight: Theme.blockHeight * 5

    StyledButton {
        id: backButton

        function tapped() {
            if (stack.currentIndex > 0) {
                stack.currentIndex -= 1;
            } else {
                (stack.currentIndex = stack.count - 1);
            }
        }
        implicitHeight: parent.height
        implicitWidth: parent.width / 8
        anchors.left: parent.left
        text: ""
        font.pixelSize: Theme.font.size.doubled
    }

    StyledButton {
        id: forwardButton

        function tapped() {
            if (stack.currentIndex < stack.count - 1) {
                stack.currentIndex += 1;
            } else {
                stack.currentIndex = 0;
            }
        }

        implicitHeight: parent.height
        implicitWidth: parent.width / 8
        anchors.right: parent.right
        text: ""
        font.pixelSize: Theme.font.size.doubled
    }

    StackLayout {
        id: stack

        anchors {
            top: parent.top
            right: forwardButton.left
            bottom: parent.bottom
            left: backButton.right
        }

        Repeater {
            model: Mpris.players.values.filter(a => a.dbusName !== "org.mpris.MediaPlayer2.playerctld")
            delegate: ColumnLayout {
                id: player

                required property MprisPlayer modelData

                spacing: height / 10

                StyledText {
                    text: player.modelData?.trackTitle ?? false ? player.modelData.trackTitle : player.modelData.dbusName.slice(23)
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height / 5
                    font.pixelSize: Theme.font.size.doubled
                    elide: Text.ElideRight
                }

                Row {
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter
                    spacing: Theme.blockHeight / 2

                    StyledButton {
                        function tapped() {
                            if (player.modelData.canGoPrevious) {
                                player.modelData.previous();
                            }
                        }

                        implicitHeight: parent.height
                        implicitWidth: implicitHeight
                        text: ""
                        font.pixelSize: Theme.font.size.doubled
                    }

                    StyledButton {
                        function tapped(eventPoint, button) {
                            switch (button) {
                            case Qt.LeftButton:
                                player.modelData.togglePlaying();
                                break;
                            case Qt.MiddleButton:
                                player.modelData.stop();
                                break;
                            case Qt.RightButton:
                                player.modelData.togglePlaying();
                                break;
                            }
                        }

                        implicitHeight: parent.height
                        implicitWidth: implicitHeight
                        text: player.modelData?.isPlaying ?? false ? "" : ""
                        font.pixelSize: Theme.font.size.doubled
                    }

                    StyledButton {
                        function tapped() {
                            if (player.modelData.canGoNext) {
                                player.modelData.next();
                            }
                        }

                        implicitHeight: parent.height
                        implicitWidth: implicitHeight
                        text: ""
                        font.pixelSize: Theme.font.size.doubled
                    }
                }
                StyledText {
                    text: player.modelData?.trackAlbum ?? false ? `${player.modelData.trackAlbum} - ${player.modelData.trackArtist}` : player.modelData?.trackArtist ?? ""
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height * 0.15
                    Layout.bottomMargin: parent.height / 20
                    elide: Text.ElideMiddle
                }
            }
        }
    }
}
