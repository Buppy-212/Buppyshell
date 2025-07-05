import Quickshell
import QtQuick
import Quickshell.Wayland
import "../services"
import "."

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: win
            required property ShellScreen modelData
            screen: modelData
            WlrLayershell.layer: WlrLayer.Background
            WlrLayershell.namespace: "buppyshell:bg"
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }
            Image {
                id: image
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: Wallpaper.path
            }
            RoundCorner {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: Theme.blockWidth
                size: Theme.rounding + 3
                corner: cornerEnum.bottomLeft
            }
            RoundCorner {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: Theme.blockWidth
                size: Theme.rounding + 3
                corner: cornerEnum.bottomRight
            }
            RoundCorner {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: Theme.blockHeight
                anchors.leftMargin: Theme.blockWidth
                size: Theme.rounding + 3
                corner: cornerEnum.topLeft
            }
            RoundCorner {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: Theme.blockHeight
                anchors.rightMargin: Theme.blockWidth
                size: Theme.rounding + 3
                corner: cornerEnum.topRight
            }
            Date {}
        }
    }
}
