import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import "root:/services"

Item {
  property real radius: Screen.height / 3
  anchors.fill: parent
  Keys.onEscapePressed: Hyprland.dispatch("global buppyshell:windows")
  Repeater {
    id: rep
    model: Hyprland.toplevels
    delegate: WrapperMouseArea {
      id: mouse
      required property int index
      required property var modelData
      x: parent.width/2 - radius * Math.cos(2 * Math.PI * index / rep.count) - width/2
      y: parent.height/2 - radius * Math.sin(2 * Math.PI * index / rep.count) - height/2
      acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true
      focus: index ? false : true
      focusPolicy: Qt.StrongFocus
      Keys.onReturnPressed: { Hyprland.dispatch(`focuswindow address:0x${modelData.address}`); Hyprland.dispatch("global buppyshell:windows") }
      Keys.onDeletePressed: modelData.wayland.close()
      onEntered: focus = true
      onClicked: (mouse) => {
        if (mouse.button ==  Qt.LeftButton) {
          Hyprland.dispatch("global buppyshell:windows")
          Hyprland.dispatch(`focuswindow address:0x${modelData.address}`) 
        } else if (mouse.button == Qt.RightButton) {
          Hyprland.dispatch("global buppyshell:windows")
          Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedWorkspace.id}, address:0x${modelData.address}`);
        } else {
          modelData.wayland.close()
        }
      }
      Behavior on x {
        animation: Theme.animation.elementMoveEnter.numberAnimation.createObject(this)
      }
      Behavior on y {
        animation: Theme.animation.elementMoveEnter.numberAnimation.createObject(this)
      }
      Rectangle {
        id: rect
        implicitWidth: rep.count < 4 ? Screen.width / 4 : Screen.width / rep.count
        implicitHeight: rep.count < 4 ? Screen.height / 4 : Screen.height / rep.count + Theme.blockHeight
        color: Theme.color.bgdark
        Column {
          anchors.fill: parent
          Rectangle {
            width: parent.width
            height: Theme.blockHeight
            color: mouse.focus ? Theme.color.accent : Theme.color.black
            Text {
              anchors.left: parent.left
              text: modelData.title
              width: parent.width
              height: parent.height
              color: Theme.color.fg
              font.family: Theme.font.family.mono
              font.pointSize: Theme.font.size.normal
              font.bold: true
              horizontalAlignment: Text.AlignHCenter
              elide: Text.ElideRight
              maximumLineCount: 1
            }
            WrapperMouseArea {
              anchors.right: parent.right
              width: height
              height: parent.height
              cursorShape: Qt.PointingHandCursor
              onClicked: modelData.wayland.close()
              Text {
                text: "close"
                color: Theme.color.red
                font.family: Theme.font.family.material
                font.pointSize: Theme.font.size.large
                font.bold: true
                horizontalAlignment: Text.AlignRight
              }
            }
          }
          Loader {
            width: rect.width
            height: rect.height - Theme.blockHeight
            sourceComponent: mouse.focus || mouse.containsMouse ? preview : icon
          }
          Component {
            id: icon
            IconImage {
              visible: !mouse.focus
              implicitSize: parent.height
              source: Quickshell.iconPath(modelData.wayland.appId)
            }
          }
          Component {
            id: preview
            ScreencopyView {
              visible: mouse.focus
              anchors.fill: parent
              captureSource: modelData.wayland
            }
          }
        }
      }
    }
  }
}
