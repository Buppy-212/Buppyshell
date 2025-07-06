import Quickshell
import QtQuick
import Quickshell.Wayland

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property ShellScreen modelData
            screen: modelData
            WlrLayershell.layer: WlrLayer.Bottom
            WlrLayershell.namespace: "buppyshell:bottom"
            exclusionMode: ExclusionMode.Ignore
            color: "transparent"
            anchors {
                right: true
            }
            margins {
                right: modelData.name === "eDP-1" ? modelData.width * 0.0795 - implicitWidth/2 : modelData.width * 0.1225 - implicitWidth/2;
            }
            implicitHeight: date.height
            implicitWidth: date.width
            Date {id: date}
        }
    }
}
