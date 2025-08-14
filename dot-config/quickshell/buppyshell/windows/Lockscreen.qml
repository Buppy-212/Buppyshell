pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.Pam
import Quickshell.Wayland
import qs.services
import qs.widgets
import qs.modules.background

WlSessionLock {
    id: lock
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
                passRect.border.color = Theme.color.blue;
                if (responseRequired) {
                    passwordField.echoMode = responseVisible ? TextInput.Normal : TextInput.Password;
                }
            }
            onCompleted: function (result) {
                if (result === PamResult.Success) {
                    GlobalState.locked = false;
                } else {
                    passRect.border.color = Theme.color.red;
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
                id: passwordField
                focus: true
                anchors {
                    fill: parent
                    margins: parent.height / 4
                }
                placeholderText: "Password"
                background: Rectangle {
                    id: passRect
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
