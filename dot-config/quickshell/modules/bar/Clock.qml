import QtQuick
import "root:/widgets"
import "root:/services"

BarBlock {
  implicitHeight: 48
  BarText {
    text: Time.time
  }
}
