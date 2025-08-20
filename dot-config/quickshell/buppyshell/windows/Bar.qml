import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import qs.services
import qs.services.wallpaper
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
        item: bar
    }
    exclusiveZone: Theme.barWidth
    WlrLayershell.namespace: "buppyshell:rightbar"

    GlassBackground {
        id: background

        anchors.fill: parent
    }

    ShaderEffectSource {
        id: effectSource

        sourceItem: background
        anchors.fill: border
        sourceRect: Qt.rect(x, y, width, height)
        visible: false
    }

    ShaderEffectSource {
        id: effectSourceBar

        sourceItem: background
        anchors.fill: bar
        sourceRect: Qt.rect(x, y, width, height)
        visible: false
    }

    Item {
        id: bar

        anchors {
            top: parent.top
            right: Theme.barOnRight ? parent.right : undefined
            bottom: parent.bottom
            left: !Theme.barOnRight ? parent.left : undefined
        }
        implicitWidth: Theme.barWidth

        MultiEffect {
            anchors.fill: parent
            source: effectSourceBar
            autoPaddingEnabled: false
            blur: 1
            blurMultiplier: 2
            blurMax: 48
            blurEnabled: true
        }

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
                Layout.preferredHeight: hovered ? Theme.doubledBlockHeight : Theme.blockHeight
            }

            StyledText {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.doubledBlockHeight
                text: Time.timeGrid
            }

            Power {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.blockHeight
            }
        }
    }
    Item {
        id: border

        anchors {
            top: parent.top
            right: Theme.barOnRight ? bar.left : parent.right
            bottom: parent.bottom
            left: Theme.barOnRight ? parent.left : bar.right
        }

        Item {
            id: mask

            anchors.fill: parent
            layer.enabled: true
            visible: false

            Rectangle {
                anchors.fill: parent
                radius: Theme.radius + 3
            }
        }

        MultiEffect {
            anchors.fill: parent
            source: effectSource
            maskEnabled: true
            maskSource: mask
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
            autoPaddingEnabled: false
            blur: 1
            blurMultiplier: 2
            blurMax: 48
            blurEnabled: true
        }
    }
}
