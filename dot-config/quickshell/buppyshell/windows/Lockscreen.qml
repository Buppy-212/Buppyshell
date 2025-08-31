pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pam
import Quickshell.Wayland
import Quickshell.Widgets
import qs.services
import qs.services.wallpaper
import qs.widgets
import qs.modules.background

WlSessionLock {
    locked: GlobalState.locked
    surface: WlSessionLockSurface {
        PamContext {
            id: pam

            active: true
            onCompleted: function (result) {
                if (result === PamResult.Success) {
                    GlobalState.locked = false;
                } else {
                    pam.active = true;
                    pam.start();
                }
            }
        }

        GlassBackground {
            id: background

            anchors.fill: parent
        }

        MultiEffect {
            anchors.fill: parent
            source: background
            autoPaddingEnabled: false
            blur: 1
            blurMultiplier: 2
            blurMax: 48
            blurEnabled: true
        }

        Date {
            height: parent.height > parent.width ? parent.width / 3 : parent.height / 3
            width: height * 2
        }

        ColumnLayout {
            id: password

            height: parent.height / 2
            width: parent.width / 4
            spacing: height / 8
            anchors.centerIn: parent

            StyledText {
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height / 8
                font.pixelSize: height
                text: Quickshell.env("USER")
            }

            ClippingRectangle {
                color: "transparent"
                Layout.preferredHeight: parent.height / 3
                Layout.preferredWidth: height
                Layout.alignment: Qt.AlignHCenter
                radius: height / 2
                Image {
                    anchors.fill: parent
                    asynchronous: true
                    fillMode: Image.PreserveAspectCrop
                    source: `${Quickshell.env("XDG_DATA_HOME")}/face`
                }
            }

            StyledTextField {
                Layout.preferredHeight: parent.height / 8
                Layout.fillWidth: true
                echoMode: TextInput.Password
                font.letterSpacing: 4
                focus: true
                onAccepted: {
                    if (pam.responseRequired) {
                        pam.respond(text);
                        text = "";
                    }
                }
            }
        }
    }
}
