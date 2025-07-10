import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import "../services"
import "../widgets"

Block {
    color: "transparent"
    StyledText {
        text: GlobalState.defaultTitle ? Hyprland.focusedWorkspace?.toplevels.values.length ? ToplevelManager.activeToplevel?.title ?? qsTr("Desktop") : qsTr("Desktop") : GlobalState.title
        width: parent.width
        horizontalAlignment: Text.AlignLeft
        elide: Text.ElideRight
        maximumLineCount: 1
    }
    MouseBlock {
        onClicked: {
            GlobalState.overlay = !GlobalState.overlay;
            GlobalState.overlayState = true;
        }
    }
}
