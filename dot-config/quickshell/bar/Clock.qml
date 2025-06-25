import QtQuick
import "root:/widgets"
import "root:/services"

Rectangle {
  implicitHeight: 48
  implicitWidth: 30
  color: "transparent"
  radius: Theme.rounding
  BarText {
    text: Time.time
  }
}
