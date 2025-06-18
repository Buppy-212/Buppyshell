import QtQuick
import "root:/widgets"
import "root:/services"

BarBlock {
  implicitHeight: 48
  disabled: true
  function onClicked(): void{
    undefined
  }
  BarText {
    text: Time.time
  }
}
