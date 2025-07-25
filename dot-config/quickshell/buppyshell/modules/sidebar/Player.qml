import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Controls
import qs.services
import qs.widgets

Rectangle {
    id: playerWidget
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
    onVisibleChanged: playerWidget.currentIndex = findPlayerctld()
    radius: Theme.radius.normal
    color: Theme.color.bg
    MouseBlock {
        onClicked: GlobalState.player = !GlobalState.player
    }
    Behavior on implicitHeight {
        animation: Theme.animation.elementMove.numberAnimation.createObject(this)
    }
    Timer {
        repeat: true
        interval: 1000
        running: Mpris.players.values[playerWidget.currentIndex]?.playbackState == MprisPlaybackState.Playing
        onTriggered: Mpris.players.values[playerWidget.currentIndex].positionChanged()
    }
    Block {
        id: backBlock
        hovered: backMouse.containsMouse
        implicitHeight: parent.height
        implicitWidth: 72
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        StyledText {
            text: ""
            font.pointSize: Theme.font.size.doubled
        }
        MouseBlock {
            id: backMouse
            onClicked: {
                if (playerWidget.currentIndex > 0) {
                    playerWidget.currentIndex -= 1;
                } else
                    (playerWidget.currentIndex = Mpris.players.values.length - 1);
            }
        }
    }
    Column {
        spacing: 6
        anchors.fill: parent
        Item {
            implicitHeight: Theme.height.doubleBlock
            implicitWidth: parent.width
            StyledText {
                text: Mpris.players.values[playerWidget.currentIndex]?.trackTitle ?? false ? Mpris.players.values[playerWidget.currentIndex].trackTitle : "No Track"
                font.pointSize: Theme.font.size.doubled
                color: Theme.color.fg
                width: parent.width - backBlock.width - forwardBlock.width
                horizontalAlignment: Text.AlignHCenter
                elide: Text.ElideRight
            }
        }
        Item {
            visible: GlobalState.player
            implicitHeight: Theme.height.block
            implicitWidth: parent.width
            StyledText {
                text: Mpris.players.values[playerWidget.currentIndex]?.trackAlbum ? `${Mpris.players.values[playerWidget.currentIndex]?.trackAlbum} - ${Mpris.players.values[playerWidget.currentIndex]?.trackArtist}` : Mpris.players.values[playerWidget.currentIndex]?.trackArtist
                color: Theme.color.fg
                width: parent.width - backBlock.width - forwardBlock.width
                horizontalAlignment: Text.AlignHCenter
                elide: Text.ElideMiddle
            }
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
        Block {
            hovered: leftMouse.containsMouse
            implicitHeight: Theme.height.doubleBlock
            implicitWidth: implicitHeight
            StyledText {
                text: ""
                font.pointSize: Theme.font.size.doubled
            }
            MouseBlock {
                id: leftMouse
                onClicked: {
                    if (Mpris.players.values[playerWidget.currentIndex].canGoPrevious) {
                        Mpris.players.values[playerWidget.currentIndex].previous();
                    }
                }
            }
        }
        Block {
            hovered: playMouse.containsMouse
            implicitHeight: Theme.height.doubleBlock
            implicitWidth: implicitHeight
            StyledText {
                text: Mpris.players.values[playerWidget.currentIndex]?.isPlaying ? "" : ""
                color: Mpris.players.values[playerWidget.currentIndex]?.dbusName == "org.mpris.MediaPlayer2.playerctld" ? Theme.color.red : Theme.color.fg
                font.pointSize: Theme.font.size.doubled
            }
            MouseBlock {
                id: playMouse
                onClicked: mouse => {
                    switch (mouse.button) {
                    case Qt.LeftButton:
                        Mpris.players.values[playerWidget.currentIndex].togglePlaying();
                        break;
                    case Qt.MiddleButton:
                        Mpris.players.values[playerWidget.currentIndex].stop();
                        break;
                    case Qt.RightButton:
                        Mpris.players.values[playerWidget.currentIndex].togglePlaying();
                        break;
                    }
                }
            }
        }
        Block {
            hovered: rightMouse.containsMouse
            implicitHeight: Theme.height.doubleBlock
            implicitWidth: implicitHeight
            StyledText {
                text: ""
                font.pointSize: Theme.font.size.doubled
            }
            MouseBlock {
                id: rightMouse
                onClicked: {
                    if (Mpris.players.values[playerWidget.currentIndex].canGoNext) {
                        Mpris.players.values[playerWidget.currentIndex].next();
                    }
                }
            }
        }
    }
    Slider {
        id: slider
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 64
        anchors.top: playbackControls.bottom
        visible: Mpris.players.values[playerWidget.currentIndex]?.positionSupported ?? false
        live: true
        height: 12
        width: parent.width / 2
        from: 0
        to: Mpris.players.values[playerWidget.currentIndex]?.length ?? 1
        value: Mpris.players.values[playerWidget.currentIndex]?.position ?? 0
        background: Rectangle {
            width: slider.availableWidth
            height: parent.height
            color: Theme.color.grey
            radius: Theme.radius.normal
            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
                color: Theme.color.blue
                radius: Theme.radius.normal
            }
        }
    }
    Block {
        id: forwardBlock
        hovered: forwardMouse.containsMouse
        implicitHeight: parent.height
        implicitWidth: 72
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        StyledText {
            text: ""
            font.pointSize: Theme.font.size.doubled
        }
        MouseBlock {
            id: forwardMouse
            onClicked: {
                if (playerWidget.currentIndex < Mpris.players.values.length - 1) {
                    playerWidget.currentIndex += 1;
                } else {
                    playerWidget.currentIndex = 0;
                }
            }
        }
    }
}
