import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.services
import qs.modules.bar

Variants {
    model: Quickshell.screens
    Scope {
        id: scope
        required property ShellScreen modelData
        PanelWindow {
            id: leftBar
            visible: GlobalState.bar
            screen: scope.modelData
            mask: Region {
                item: leftRect
            }
            WlrLayershell.namespace: "buppyshell:leftbar"
            anchors {
                top: true
                left: true
                bottom: true
            }
            implicitWidth: Theme.width.block + Theme.radius.normalAdjusted
            exclusiveZone: Theme.width.block
            color: "transparent"
            LeftBar {
                id: leftRect
            }
            RoundCorner {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: Theme.width.block
                size: Theme.radius.normalAdjusted
                corner: cornerEnum.bottomLeft
            }
            RoundCorner {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: Theme.width.block
                size: Theme.radius.normalAdjusted
                corner: cornerEnum.topLeft
            }
        }
        PanelWindow {
            id: rightBar
            visible: GlobalState.bar
            screen: scope.modelData
            mask: Region {
                item: rightRect
            }
            WlrLayershell.namespace: "buppyshell:rightbar"
            anchors {
                top: true
                right: true
                bottom: true
            }
            implicitWidth: Theme.width.block + Theme.radius.normalAdjusted
            exclusiveZone: Theme.width.block
            color: "transparent"
            RightBar {
                id: rightRect
            }
            RoundCorner {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: Theme.width.block
                size: Theme.radius.normalAdjusted
                corner: cornerEnum.bottomRight
            }
            RoundCorner {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: Theme.width.block
                size: Theme.radius.normalAdjusted
                corner: cornerEnum.topRight
            }
        }
    }
}
