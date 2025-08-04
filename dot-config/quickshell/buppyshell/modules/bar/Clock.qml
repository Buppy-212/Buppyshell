import qs.services
import qs.widgets

Block {
    implicitHeight: Theme.height.doubleBlock
    color: "transparent"
    StyledText {
        text: Time.timeGrid
        anchors.fill: parent
    }
}
