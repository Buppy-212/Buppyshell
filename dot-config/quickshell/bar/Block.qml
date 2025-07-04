import QtQuick
import "root:/services"

Rectangle {
  implicitWidth: Theme.blockWidth
  implicitHeight: Theme.blockHeight
  color: mouse.containsMouse ? Theme.color.grey : "transparent"
  radius: Theme.rounding
}
