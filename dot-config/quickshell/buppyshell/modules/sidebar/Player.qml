import Quickshell.Services.Mpris
import QtQuick
import qs.services
import qs.widgets

Rectangle {
    id: root
    property int currentIndex: findPlayerctld()
    function findPlayerctld(): int {
        for (var i = 0; i < Mpris.players.values.length; i++) {
            if (Mpris.players.values[i].dbusName === "org.mpris.MediaPlayer2.playerctld") {
                return i;
            }
        }
    }
    radius: Theme.radius.normal
    color: Theme.color.bg
    TapHandler {
        onTapped: GlobalState.player = !GlobalState.player
    }
    HoverHandler {
        cursorShape: Qt.PointingHandCursor
    }
    Timer {
        repeat: true
        interval: 1000
        running: Mpris.players.values[root.currentIndex]?.playbackState === MprisPlaybackState.Playing
        onTriggered: Mpris.players.values[root.currentIndex].positionChanged()
    }
    StyledButton {
        id: backButton
        implicitHeight: parent.height
        implicitWidth: root.width / 8
        anchors.left: parent.left
        text: ""
        font.pixelSize: width / 2
        function tapped() {
            if (root.currentIndex > 0) {
                root.currentIndex -= 1;
            } else {
                (root.currentIndex = Mpris.players.values.length - 1);
            }
        }
    }
    Column {
        spacing: 6
        anchors.fill: parent
        StyledText {
            text: Mpris.players.values[root.currentIndex]?.trackTitle ?? false ? Mpris.players.values[root.currentIndex].trackTitle : "No Track"
            height: GlobalState.player ? root.height / 6 : root.height / 2
            width: parent.width - 2 * backButton.width
            font.pixelSize: height * 0.75
            anchors.horizontalCenter: parent.horizontalCenter
            elide: Text.ElideRight
        }
        StyledText {
            text: Mpris.players.values[root.currentIndex]?.trackAlbum ? `${Mpris.players.values[root.currentIndex]?.trackAlbum} - ${Mpris.players.values[root.currentIndex]?.trackArtist}` : Mpris.players.values[root.currentIndex]?.trackArtist ?? ""
            visible: GlobalState.player
            height: Theme.height.block
            width: parent.width - 2 * backButton.width
            anchors.horizontalCenter: parent.horizontalCenter
            elide: Text.ElideMiddle
        }
    }
    Row {
        id: playbackControls
        anchors {
            bottom: parent.bottom
            bottomMargin: GlobalState.player ? parent.height / 2 - height / 2 : 0
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 24
        Behavior on anchors.bottomMargin {
            animation: Theme.animation.elementMove.numberAnimation.createObject(this)
        }
        StyledButton {
            implicitHeight: Theme.height.doubleBlock
            implicitWidth: implicitHeight
            text: ""
            font.pixelSize: height * 0.75
            function tapped() {
                if (Mpris.players.values[root.currentIndex].canGoPrevious) {
                    Mpris.players.values[root.currentIndex].previous();
                }
            }
        }
        StyledButton {
            implicitHeight: Theme.height.doubleBlock
            implicitWidth: implicitHeight
            text: Mpris.players.values[root.currentIndex]?.isPlaying ? "" : ""
            color: Mpris.players.values[root.currentIndex]?.dbusName === "org.mpris.MediaPlayer2.playerctld" ? Theme.color.red : Theme.color.fg
            font.pixelSize: height * 0.75
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
            implicitHeight: Theme.height.doubleBlock
            implicitWidth: implicitHeight
            text: ""
            font.pixelSize: height * 0.75
            function tapped() {
                if (Mpris.players.values[root.currentIndex].canGoNext) {
                    Mpris.players.values[root.currentIndex].next();
                }
            }
        }
    }
    StyledSlider {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: root.height / 8
        }
        visible: GlobalState.player && Mpris.players.values[root.currentIndex]?.positionSupported
        height: root.height / 16
        width: parent.width / 2
        to: Mpris.players.values[root.currentIndex]?.length ?? 1
        value: Mpris.players.values[root.currentIndex]?.position ?? 0
        HoverHandler {
            cursorShape: Qt.PointingHandCursor
        }
    }
    StyledButton {
        id: forwardBlock
        implicitHeight: parent.height
        implicitWidth: root.width / 8
        anchors.right: parent.right
        text: ""
        font.pixelSize: width / 2
        function tapped() {
            if (root.currentIndex < Mpris.players.values.length - 1) {
                root.currentIndex += 1;
            } else {
                root.currentIndex = 0;
            }
        }
    }
}
