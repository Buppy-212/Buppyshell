import "root:/services"
import "."

Block {
  StyledText {
    text: mouse.containsMouse ? Brightness.brightness : Brightness.nightlight ? "bedtime" : "light_mode"
    color: Theme.color.yellow
    font.family: mouse.containsMouse ? Theme.font.family.mono : Theme.font.family.material
    font.pointSize: mouse.containsMouse ? Theme.font.size.normal : Theme.font.size.large
  }
  MouseBlock {
    id: mouse
    onClicked: (mouse) => {
      if (mouse.button == Qt.LeftButton) {
        Brightness.toggleNightlight()
      } else
      Brightness.monitor()
    }
    onWheel: (wheel) => {
      if (wheel.angleDelta.y > 0) {
        Brightness.inc()
      } else {
        Brightness.dec()
      }
    }
  }
}

