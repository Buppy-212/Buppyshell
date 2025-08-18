pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Hyprland
import Quickshell.Wayland
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
    color: Theme.color.black
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

    MultiEffect {
        autoPaddingEnabled: false
        source: background
        anchors.fill: background
        blur: 1
        blurMax: 64
        blurEnabled: true
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.color.bgTranslucent
    }

    ColumnLayout {
        id: column

        anchors {
            fill: parent
            topMargin: spacing / 2
        }
        spacing: parent.height / 24

        Searchbar {
            id: searchbar
            Layout.preferredHeight: Theme.doubledBlockHeight
            Layout.preferredWidth: column.width / 3
            Layout.alignment: Qt.AlignHCenter
            forwardTargets: [stackView.currentItem]
        }

        StackView {
            id: stackView

            readonly property int launcherModule: GlobalState.launcherModule

            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.8

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
                case GlobalState.LauncherModule.Logout:
                    stackView.replaceCurrentItem(Quickshell.shellPath("modules/launcher/Logout.qml"));
                    break;
                }
            }
        }

        Taskbar {
            Layout.preferredHeight: Theme.doubledBlockHeight
            Layout.fillWidth: true
        }
    }
}
