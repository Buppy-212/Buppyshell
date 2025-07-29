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
            height: Screen.height / 10
            width: Screen.width / 6
            color: Theme.color.bgTranslucent
            radius: height / 3
            anchors.centerIn: parent
            Column {
                anchors {
                  fill: parent
                  leftMargin: parent.width / 16
                  rightMargin: parent.width / 16
                }
                topPadding: spacing
                spacing: parent.height / 8
                Item {
                    width: parent.width
                    height: parent.height / 8
                    StyledText {
                      text: "Password"
                      font.pixelSize: height
                    }
                }
                Rectangle {
                    id: passRect
                    anchors.horizontalCenter: parent.horizontalCenter
                    implicitWidth: parent.width
                    implicitHeight: parent.height / 2
                    border.width: Theme.border
                    radius: height / 3
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
