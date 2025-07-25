pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.Pam
import Quickshell.Wayland
import qs.services
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
                    passwordField.focus = true;
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
            height: parent.height
            width: Screen.width * 0.33
            color: Theme.color.bgTranslucent
            anchors.centerIn: parent
            Column {
                anchors.centerIn: parent
                spacing: Screen.height * 0.2
                Text {
                    id: time
                    text: Time.lockTime
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: Theme.color.fg
                    font.pointSize: Theme.font.size.huge
                    font.family: Theme.font.family.sans
                    font.bold: true
                }
                Column {
                    spacing: Theme.margin.small
                    Text {
                        color: Theme.color.fg
                        font.pointSize: Theme.font.size.normal
                        font.family: Theme.font.family.sans
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: pam.message
                    }
                    Rectangle {
                        id: passRect
                        anchors.horizontalCenter: parent.horizontalCenter
                        border.width: Theme.border
                        radius: Theme.radius.medium
                        width: 300
                        height: 60
                        color: Theme.color.bg
                        TextInput {
                            id: passwordField
                            anchors.centerIn: passRect
                            color: Theme.color.fg
                            visible: true
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
        }
    }
}
