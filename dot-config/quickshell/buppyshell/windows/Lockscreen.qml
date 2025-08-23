pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import Quickshell.Services.Pam
import Quickshell.Wayland
import Quickshell.Widgets
import qs.services
import qs.services.wallpaper
import qs.widgets
import qs.modules.background

WlSessionLock {
    locked: GlobalState.locked

    WlSessionLockSurface {
        Image {
            cache: false
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: Wallpapers.current
        }

        GlassBackground {
            id: background

            anchors.fill: parent
        }

        ShaderEffectSource {
            id: effectSourcePassword

            sourceItem: background
            anchors.fill: password
            sourceRect: Qt.rect(x, y, width, height)
            visible: false
        }

        Date {
            height: parent.height > parent.width ? parent.width / 3 : parent.height / 3
            width: height
        }

        PamContext {
            id: pam
            active: true
            onPamMessage: {
                textFieldBackground.border.color = Theme.color.blue;
                if (responseRequired) {
                    textField.echoMode = responseVisible ? TextInput.Normal : TextInput.Password;
                }
            }
            onCompleted: function (result) {
                if (result === PamResult.Success) {
                    GlobalState.locked = false;
                } else {
                    textFieldBackgroune.border.color = Theme.color.red;
                    pam.active = true;
                    pam.start();
                }
            }
        }

        ClippingRectangle {
            id: password

            height: Screen.height / 10
            width: Screen.width / 6
            color: "transparent"
            radius: height / 3
            anchors.centerIn: parent

            MultiEffect {
                anchors.fill: parent
                source: effectSourcePassword
                autoPaddingEnabled: false
                blur: 1
                blurMultiplier: 2
                blurMax: 48
                blurEnabled: true
            }

            StyledTextField {
                id: textField
                focus: true
                anchors {
                    fill: parent
                    margins: parent.height / 4
                }
                placeholderText: "Password"
                background: Rectangle {
                    id: textFieldBackground
                    border {
                        width: 2
                        color: Theme.color.blue
                    }
                    radius: height / 3
                    color: Theme.color.bg
                }
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
