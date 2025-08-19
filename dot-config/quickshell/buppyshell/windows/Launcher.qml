pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import qs.services
import qs.widgets
import qs.modules.launcher

PanelWindow {
    id: root

    required property ShellScreen modelData
    readonly property bool launcherVisible: GlobalState.launcher
    property string monitor

    onLauncherVisibleChanged: {
        root.monitor = Hyprland.focusedMonitor?.name ?? "";
    }
    anchors {
        top: true
        right: true
        bottom: true
        left: true
    }
    visible: GlobalState.launcher && modelData.name === monitor
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "buppyshell:launcher"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    TapHandler {
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        onTapped: GlobalState.launcher = false
    }

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: Wallpaper.path
        visible: false
    }

    ClippingRectangle {
        id: launcher

        anchors.centerIn: parent
        implicitWidth: modelData.width * 0.5
        implicitHeight: (Theme.margin * 4) + (Theme.blockHeight * 4) * 11
        radius: Theme.radius

        MultiEffect {
            autoPaddingEnabled: false
            source: background
            width: background.width
            height: background.height
            blur: 1
            blurMax: 64
            blurEnabled: true
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.color.bgTranslucent
            radius: Theme.radius
            border.color: Theme.color.blue
            border.width: Theme.border
        }

        ColumnLayout {
            anchors {
                fill: parent
                margins: Theme.margin
            }
            spacing: Theme.margin

            Searchbar {
                id: searchbar
                Layout.preferredHeight: Theme.doubledBlockHeight
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                forwardTargets: [stackView.currentItem]
            }

            StackView {
                id: stackView

                readonly property int launcherModule: GlobalState.launcherModule

                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                Layout.fillWidth: true

                onLauncherModuleChanged: {
                    switch (launcherModule) {
                    case GlobalState.LauncherModule.AppLauncher:
                        stackView.replaceCurrentItem(Quickshell.shellPath("modules/launcher/AppLauncher.qml"), {
                            "search": Qt.binding(function () {
                                return searchbar.text;
                            })
                        });
                        break;
                    case GlobalState.LauncherModule.WindowSwitcher:
                        stackView.replaceCurrentItem(Quickshell.shellPath("modules/launcher/WindowSwitcher.qml"), {
                            "search": Qt.binding(function () {
                                return searchbar.text;
                            })
                        });
                        break;
                    case GlobalState.LauncherModule.BookmarkLauncher:
                        stackView.replaceCurrentItem(Quickshell.shellPath("modules/launcher/BookmarkLauncher.qml"), {
                            "search": Qt.binding(function () {
                                return searchbar.text;
                            })
                        });
                        break;
                    case GlobalState.LauncherModule.Logout:
                        stackView.replaceCurrentItem(Quickshell.shellPath("modules/launcher/Logout.qml"));
                        break;
                    }
                }
            }

            ClippingRectangle {
                Layout.preferredHeight: Theme.doubledBlockHeight
                Layout.fillWidth: true
                radius: Theme.radius
                color: Theme.color.bgalt
                Tabs {
                    anchors.fill: parent
                }
            }
        }
    }
}
