import Quickshell
import Quickshell.Widgets
import QtQuick
import Quickshell.Services.Mpris
import "root:/services"

ClippingRectangle {
  id: root
  property bool revealed: false
  implicitWidth: Theme.blockWidth
  implicitHeight: revealed ? (Mpris.players.values.length) * 24 : 24
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
    Block {
      implicitWidth: Theme.blockWidth - 2
      SymbolText {
        text: Mpris.players.values[0].isPlaying ? "pause" : "resume"
      }
      MouseBlock {
        id: mouse
        onClicked: (mouse) => {
          if (mouse.button == Qt.RightButton) {
            root.revealed = !root.revealed
          } else {
            Mpris.players.values[0].togglePlaying()
          }
        }
        onEntered: Hyprland.overrideTitle(`${Mpris.players.values[0].identity}: ${Mpris.players.values[0].trackTitle}`)
      }
    }
    Repeater {
      model: Mpris.players
      delegate: Block {
        visible: index != 0 && root.revealed
        Behavior on visible {
          animation: Theme.animation.elementMove.numberAnimation.createObject(this)
        }
        implicitWidth: Theme.blockWidth - 2
        SymbolText{
          text: modelData.isPlaying ? "pause" : "resume"
        }
        MouseBlock {
          id: mouse
          onClicked: modelData.togglePlaying()
          onEntered: Hyprland.overrideTitle(`${modelData.identity}: ${modelData.trackTitle}`)
        }
      }
    }
  }
}
