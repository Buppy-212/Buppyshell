import "../../services"
import "../../widgets"

Block {
    implicitHeight: Theme.height.doubleBlock
    color: "transparent"
    StyledText {
        text: Time.time
    }
}
