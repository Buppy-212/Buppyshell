import Quickshell.Services.Mpris
import QtQuick
import qs.services
import qs.widgets

Rectangle {
    id: root
    function findPlayerctld(): int {
        for (var i = 0; i < Mpris.players.values.length; i++) {
            if (Mpris.players.values[i].dbusName == "org.mpris.MediaPlayer2.playerctld") {
                return i;
            }
        }
    }
    property int currentIndex: findPlayerctld()
    implicitWidth: 600
    implicitHeight: GlobalState.player ? 300 : 96
    onVisibleChanged: root.currentIndex = findPlayerctld()
    radius: Theme.radius.normal
    color: Theme.color.bg
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
    }
    Behavior on implicitHeight {
        animation: Theme.animation.elementMove.numberAnimation.createObject(this)
    }
    Timer {
        repeat: true
        interval: 1000
        running: Mpris.players.values[root.currentIndex]?.playbackState == MprisPlaybackState.Playing
        onTriggered: Mpris.players.values[root.currentIndex].positionChanged()
    }
    StyledButton {
        id: backButton
        implicitHeight: parent.height
        implicitWidth: 72
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
    Column {
        spacing: 6
        anchors.fill: parent
        StyledText {
            text: Mpris.players.values[root.currentIndex]?.trackTitle ?? false ? Mpris.players.values[root.currentIndex].trackTitle : "No Track"
            height: Theme.height.doubleBlock
            width: parent.width - 2 * backButton.width
            font.pixelSize: Theme.font.size.doubled
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
        anchors.bottom: parent.bottom
        anchors.bottomMargin: GlobalState.player ? parent.height / 2 - height / 2 : 0
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 24
        Behavior on anchors.bottomMargin {
            animation: Theme.animation.elementMove.numberAnimation.createObject(this)
        }
        StyledButton {
            implicitHeight: Theme.height.doubleBlock
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
            implicitHeight: Theme.height.doubleBlock
            implicitWidth: implicitHeight
            text: Mpris.players.values[root.currentIndex]?.isPlaying ? "" : ""
            color: Mpris.players.values[root.currentIndex]?.dbusName == "org.mpris.MediaPlayer2.playerctld" ? Theme.color.red : Theme.color.fg
            font.pixelSize: Theme.font.size.doubled
            function tapped(pointEvent, button) {
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
            font.pixelSize: Theme.font.size.doubled
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
            topMargin: 64
            top: playbackControls.bottom
        }
        visible: GlobalState.player && Mpris.players.values[root.currentIndex]?.positionSupported
        height: 12
        width: parent.width / 2
        to: Mpris.players.values[root.currentIndex]?.length ?? 1
        value: Mpris.players.values[root.currentIndex]?.position ?? 0
    }
    StyledButton {
        id: forwardBlock
        implicitHeight: parent.height
        implicitWidth: 72
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
