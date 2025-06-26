import QtQuick
import "root:/services"

Rectangle {
  implicitHeight: Theme.blockHeight*2
  implicitWidth: Theme.blockWidth
  color: "transparent"
  radius: Theme.rounding
  Text {
    text: Time.time
    color: Theme.color.fg
    font.family: Theme.font.family.mono
    font.pointSize: Theme.font.size.normal
    font.bold: true
    anchors.centerIn: parent
  }
}
