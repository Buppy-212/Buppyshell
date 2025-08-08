pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Wayland
import qs.services
import qs.widgets
import qs.modules.launcher

LazyLoader {
    loading: true
    component: PanelWindow {
        id: panelWindow
        visible: GlobalState.launcher
        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.namespace: "buppyshell:launcher"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
        exclusionMode: ExclusionMode.Ignore
        color: Theme.color.black
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
            onClicked: GlobalState.launcher = false
        }
        anchors {
            top: true
            right: true
            bottom: true
            left: true
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
            color: Theme.color.bg
            opacity: 0.85
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
                Layout.preferredHeight: panelWindow.height / 24
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
                Layout.preferredHeight: panelWindow.height / 24
                Layout.fillWidth: true
            }
        }
    }
}
