import "../services"
import "../widgets"

Block {
    color: "transparent"
    implicitWidth: text.contentWidth + 4
    StyledText {
        id: text
        text: Time.lockTime
    }
}
