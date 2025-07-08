import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import "../services/"

Column {
    id: playerWidget
    spacing: 1
    property int currentIndex: findPlayerctld()
    Block {
        hovered: upMouse.containsMouse
        SymbolText {
            text: "arrow_upward"
        }
        MouseBlock {
            id: upMouse
            onClicked: mouse => {
                switch (mouse.button) {
                case Qt.LeftButton:
                    Mpris.players.values[playerWidget.currentIndex].previous();
                    break;
                case Qt.RightButton:
                    if (playerWidget.currentIndex > 0) {
                        playerWidget.currentIndex -= 1;
                    } else
                        (playerWidget.currentIndex = Mpris.players.values.length - 1);
                    GlobalState.overrideTitle(`${Mpris.players.values[playerWidget.currentIndex].trackTitle} -- ${Mpris.players.values[playerWidget.currentIndex].trackArtist}`);
                    break;
                }
            }
            onEntered: GlobalState.overrideTitle(`${Mpris.players.values[playerWidget.currentIndex].trackTitle} -- ${Mpris.players.values[playerWidget.currentIndex].trackArtist}`)
            onExited: GlobalState.refreshTitle()
        }
    }
    Block {
        hovered: mouse.containsMouse
        SymbolText {
            text: Mpris.players.values[playerWidget.currentIndex].isPlaying ? "pause" : "resume"
            color: Mpris.players.values[playerWidget.currentIndex].dbusName == "org.mpris.MediaPlayer2.playerctld" ? Theme.color.red : Theme.color.fg
        }
        MouseBlock {
            id: mouse
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
            onWheel: wheel => {
                if (wheel.angleDelta.y > 0) {
                    Mpris.players.values[playerWidget.currentIndex].seek(5);
                } else {
                    Mpris.players.values[playerWidget.currentIndex].seek(-5);
                }
            }
            onEntered: GlobalState.overrideTitle(`${Mpris.players.values[playerWidget.currentIndex].trackTitle} -- ${Mpris.players.values[playerWidget.currentIndex].trackArtist}`)
            onExited: GlobalState.refreshTitle()
        }
    }
    Block {
        hovered: downMouse.containsMouse
        SymbolText {
            text: "arrow_downward"
        }
        MouseBlock {
            id: downMouse
            onClicked: mouse => {
                switch (mouse.button) {
                case Qt.LeftButton:
                    Mpris.players.values[playerWidget.currentIndex].next();
                    break;
                case Qt.RightButton:
                    if (playerWidget.currentIndex < Mpris.players.values.length - 1) {
                        playerWidget.currentIndex += 1;
                    } else {
                        playerWidget.currentIndex = 0;
                    }
                    GlobalState.overrideTitle(`${Mpris.players.values[playerWidget.currentIndex].trackTitle} -- ${Mpris.players.values[playerWidget.currentIndex].trackArtist}`);
                    break;
                }
            }
            onEntered: GlobalState.overrideTitle(`${Mpris.players.values[playerWidget.currentIndex].trackTitle} -- ${Mpris.players.values[playerWidget.currentIndex].trackArtist}`)
            onExited: GlobalState.refreshTitle()
        }
    }
    function findPlayerctld(): int {
        for (var i = 0; i < Mpris.players.values.length; i++) {
            if (Mpris.players.values[i].dbusName == "org.mpris.MediaPlayer2.playerctld") {
                return i;
            }
        }
    }
}
