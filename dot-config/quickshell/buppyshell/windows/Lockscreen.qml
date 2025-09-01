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

Scope {
    id: root

    property string statusText

    PamContext {
        id: pam

        onPamMessage: {
            if (messageIsError) {
                root.statusText = message;
            }
        }
        onCompleted: result => {
            switch (result) {
            case PamResult.Success:
                GlobalState.locked = false;
                break;
            default:
                root.statusText = PamResult.toString(result);
                pam.start();
            }
        }
    }
    WlSessionLock {
        locked: GlobalState.locked
        onSecureChanged: {
            if (secure) {
                root.statusText = "";
                pam.start();
            }
        }
        surface: WlSessionLockSurface {
            Image {
                anchors.fill: parent
                asynchronous: true
                fillMode: Image.PreserveAspectCrop
                source: Wallpapers.current
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
                id: column

                height: parent.height / 2
                width: parent.width / 6
                spacing: 0
                anchors.centerIn: parent

                StyledText {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    font.pixelSize: height / 2
                    text: Quickshell.env("USER")
                }

                ClippingRectangle {
                    color: "transparent"
                    Layout.preferredHeight: width
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    radius: height / 2
                    Image {
                        anchors.fill: parent
                        asynchronous: true
                        fillMode: Image.PreserveAspectCrop
                        source: `${Quickshell.env("XDG_STATE_HOME")}/wallpaper`
                    }
                }

                StyledText {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: root.statusText
                }

                StyledTextField {
                    id: textField

                    Layout.preferredHeight: column.height / 10
                    Layout.fillWidth: true
                    echoMode: TextInput.Password
                    font.letterSpacing: 4
                    focus: true
                    onAccepted: {
                        if (pam.responseRequired) {
                            root.statusText = "Authenticating";
                            pam.respond(text);
                            text = "";
                        }
                    }
                    StyledButton {
                        function tapped(): void {
                            textField.echoMode === TextInput.Password ? textField.echoMode = TextInput.Normal : textField.echoMode = TextInput.Password;
                        }

                        anchors {
                            top: parent.top
                            right: parent.right
                            bottom: parent.bottom
                        }
                        width: height
                        font.pixelSize: height / 2
                        text: textField.echoMode === TextInput.Password ? "" : ""
                    }
                }
            }
        }
    }
}
