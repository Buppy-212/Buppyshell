pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.Pam
import Quickshell.Wayland
import qs.services
import qs.widgets
import qs.modules.background

WlSessionLock {
    locked: GlobalState.locked

    WlSessionLockSurface {
        Image {
            id: image
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: Wallpaper.path
        }

        Date {}

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

        Rectangle {
            height: Screen.height / 10
            width: Screen.width / 6
            color: Theme.color.bgTranslucent
            radius: height / 3
            anchors.centerIn: parent

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
