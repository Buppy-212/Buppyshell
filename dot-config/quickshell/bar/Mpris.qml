import Quickshell
import Quickshell.Widgets
import QtQuick
import Quickshell.Services.Mpris
import "root:/services"

ClippingRectangle {
  id: root
  property bool revealed: false
  implicitWidth: Theme.blockWidth
  implicitHeight: revealed ? (Mpris.players.values.length - 1) * 24 : 24
  color: "transparent"
  Behavior on implicitHeight {
    animation: Theme.animation.elementMoveFast.numberAnimation.createObject(this)
  }
  MouseBlock {
    onEntered: Hyprland.refreshTitle()
  }
  Column {
    width: Theme.blockWidth - 2
    anchors.horizontalCenter: parent.horizontalCenter
    Repeater {
      model: Mpris.players
      delegate: Block {
        visible: (modelData.dbusName == "org.mpris.MediaPlayer2.playerctld") != root.revealed
        Behavior on visible {
          animation: Theme.animation.elementMove.numberAnimation.createObject(this)
        }
        implicitWidth: Theme.blockWidth - 2
        SymbolText{
          text: modelData.isPlaying ? "pause" : "resume"
        }
        MouseBlock {
          id: mouse
          onClicked: (mouse) => {
              if (mouse.button == Qt.RightButton) {
                root.revealed = !root.revealed
              } else {
                modelData.togglePlaying()
              }
          }
          onEntered: Hyprland.overrideTitle(`${modelData.identity}: ${modelData.trackTitle}`)
        }
      }
    }
  }
}
