import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets
import qs.modules.bar

PanelWindow {
    id: root

    required property ShellScreen modelData

    screen: modelData
    anchors {
        top: true
        right: Theme.barOnRight
        bottom: true
        left: !Theme.barOnRight
    }
    implicitWidth: modelData.width
    color: "transparent"
    mask: Region {
        item: rectangle
    }
    exclusiveZone: Theme.barWidth
    WlrLayershell.namespace: "buppyshell:rightbar"

    Rectangle {
        id: rectangle

        anchors {
            top: parent.top
            right: Theme.barOnRight ? parent.right : undefined
            bottom: parent.bottom
            left: !Theme.barOnRight ? parent.left : undefined
        }
        implicitWidth: Theme.barWidth
        color: Theme.color.black

        ColumnLayout {
            anchors.fill: parent
            spacing: Theme.spacing

            Os {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.blockHeight
            }

            Bell {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.blockHeight
            }

            Workspaces {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Tray {
                Layout.fillWidth: true
            }

            Volume {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.blockHeight
            }

            Bluetooth {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.blockHeight
            }

            Inhibitor {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.blockHeight
            }

            Network {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.blockHeight
            }

            Battery {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.blockHeight
            }

            Light {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.blockHeight
            }

            Update {
                Layout.fillWidth: true
                Layout.preferredHeight: hovered ? Theme.blockHeight * 2 : Theme.blockHeight
            }

            StyledText {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.blockHeight * 2
                text: Time.timeGrid
            }

            Power {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.blockHeight
            }
        }
    }

    RoundCorner {
        anchors.top: parent.top
        anchors.left: Theme.barOnRight ? parent.left : rectangle.right
        corner: RoundCorner.TopLeft
    }

    RoundCorner {
        anchors.bottom: parent.bottom
        anchors.left: Theme.barOnRight ? parent.left : rectangle.right
        corner: RoundCorner.BottomLeft
    }

    RoundCorner {
        anchors.bottom: parent.bottom
        anchors.right: Theme.barOnRight ? rectangle.left : parent.right
        corner: RoundCorner.BottomRight
    }

    RoundCorner {
        anchors.top: parent.top
        anchors.right: Theme.barOnRight ? rectangle.left : parent.right
        corner: RoundCorner.TopRight
    }
}
