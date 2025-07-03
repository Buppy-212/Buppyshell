import Quickshell
import Quickshell.Widgets
import QtQuick
import Quickshell.Services.Mpris
import "root:/services"

ClippingRectangle {
  id: root
  property bool revealed: false
  implicitWidth: Theme.blockWidth
  implicitHeight: revealed ? (Mpris.players.values.length - 1) * 26 : 26
  color: "transparent"
  Behavior on implicitHeight {
    animation: Theme.animation.elementMoveFast.numberAnimation.createObject(this)
  }
  MouseBlock {
    onEntered: Hyprland.refreshTitle()
  }
  Column {
    spacing: 2
    anchors.fill: parent
    Repeater {
      model: Mpris.players
      delegate: Block {
        visible: (modelData.dbusName == "org.mpris.MediaPlayer2.playerctld") != root.revealed
        Behavior on visible {
          animation: Theme.animation.elementMove.numberAnimation.createObject(this)
        }
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
          onExited: Hyprland.refreshTitle()
        }
      }
    }
  }
}
