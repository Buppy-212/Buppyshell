import Quickshell.Hyprland
import QtQuick
import "../services"

Block {
    implicitWidth: Screen.width * 0.5
    color: "transparent"
    StyledText {
        id: text
        property real xScale: 1
        text: GlobalState.defaultTitle && Hyprland.activeToplevel ? Hyprland.activeToplevel.title : GlobalState.title
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideRight
        maximumLineCount: 1
    }
    MouseBlock {
        onClicked: Hyprland.dispatch("global buppyshell:windows")
    }
}
