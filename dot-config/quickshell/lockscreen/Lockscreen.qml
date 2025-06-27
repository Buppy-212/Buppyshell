import Quickshell
import QtQuick
import Quickshell.Services.Pam
import Quickshell.Wayland
import Quickshell.Hyprland
import "root:/services"
import "root:/background"

Scope {
  WlSessionLock {
    id: lock
    locked: false
    WlSessionLockSurface {
      Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: Theme.wallpaper
      }
      Date {}
      PamContext {
        id: pam
        active: true
        onPamMessage: {
          passRect.border.color = Theme.color.blue
          if (responseRequired) {
            passwordField.focus = true
            passwordField.echoMode = responseVisible ? TextInput.Normal : TextInput.Password
          }
        }
        onCompleted: function(result) {
          if (result === PamResult.Success) {
            lock.locked = false
          } else {
            passRect.border.color = Theme.color.red
            pam.active = true
            pam.start()
          }
        }
      }
      Rectangle {
        height: parent.height
        width: Screen.width * 0.33
        color: "#aa222436"
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
            font.family: Theme.font.sans
            font.bold: true
          }
          Column {
            spacing: Theme.border * 2
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
              radius: Theme.rounding * 2
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
                    pam.respond(text)
                    text = ""
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  GlobalShortcut {
    name: "lock"
    description: "Locks the user session"
    appid: "buppyshell"
    onPressed: {
      lock.locked = !lock.locked;
    }
  }
}
