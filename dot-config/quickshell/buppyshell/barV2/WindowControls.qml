import Quickshell.Hyprland
import QtQuick
import "../services"
import "../widgets"

Row {
    id: windowControls
    readonly property int groupLength: Hyprland.activeToplevel?.lastIpcObject?.grouped?.length ?? 0
    readonly property bool grouped: groupLength
    readonly property bool locked: Hyprland.activeToplevel?.lastIpcObject?.tags?.includes("locked") ?? false
    visible: Hyprland.focusedWorkspace?.toplevels.values.length ?? false
    Block {
        visible: windowControls.groupLength >= 2
        hovered: mouseBack.containsMouse
        StyledText {
            text: ""
        }
        MouseBlock {
            id: mouseBack
            onClicked: Hyprland.dispatch("changegroupactive b")
        }
    }
    Block {
        visible: windowControls.groupLength >= 2
        hovered: mouseForward.containsMouse
        StyledText {
            text: ""
        }
        MouseBlock {
            id: mouseForward
            onClicked: Hyprland.dispatch("changegroupactive f")
        }
    }
    Block {
        visible: windowControls.grouped
        color: mouseLock.containsMouse ? Theme.color.grey : "transparent"
        StyledText {
            text: windowControls.locked ? "" : ""
            color: Theme.color.orange
        }
        MouseBlock {
            id: mouseLock
            onClicked: {
                Hyprland.dispatch("lockactivegroup toggle");
                Hyprland.dispatch("tagwindow locked");
                Hyprland.refreshToplevels();
            }
        }
    }
    Block {
        hovered: mouseGroup.containsMouse
        StyledText {
            text: windowControls.grouped ? "󰓩" : ""
            color: Theme.color.green
        }
        MouseBlock {
            id: mouseGroup
            onClicked: {
                Hyprland.dispatch("togglegroup");
                Hyprland.dispatch("tagwindow -- -locked");
                Hyprland.refreshToplevels();
            }
        }
    }
    Block {
        hovered: mouseClose.containsMouse
        StyledText {
            text: "󰖭"
            color: Theme.color.red
        }
        MouseBlock {
            id: mouseClose
            onClicked: Hyprland.activeToplevel.wayland.close()
        }
    }
}
