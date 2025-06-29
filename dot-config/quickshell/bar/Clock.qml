import "root:/services"
import "."

Block {
  implicitHeight: Theme.blockHeight*2
  color: "transparent"
  StyledText {
    text: Time.time
  }
}
