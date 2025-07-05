import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import "root:/services"

Scope {
  id: root
  property bool visible: false
  required property string source
  LazyLoader {
    id: loader
    loading: visible
    component: PanelWindow {
      id: panel
      visible: root.visible
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.namespace: "buppyshell:launcher"
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
      exclusionMode: ExclusionMode.Ignore
      color: "#aa222436"
      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        onClicked: root.visible = false
      }
      anchors {
        top: true
        right: true
        bottom: true
        left: true
      }
      Loader {
        id: loader
        active: root.visible
        focus: true
        anchors.fill: parent
        source: root.source
      }
    }
  }
  GlobalShortcut {
    name: "launcher"
    description: "Toggle application launcher"
    appid: "buppyshell"
    onPressed: {
      visible = !root.visible;
      source = "Applications.qml";
    }
  }
  GlobalShortcut {
    name: "windows"
    description: "Toggle window switcher"
    appid: "buppyshell"
    onPressed: {
      visible = !root.visible;
      source = "Windows.qml";
    }
  }
  GlobalShortcut {
    name: "logout"
    description: "Toggle logout menu"
    appid: "buppyshell"
    onPressed: {
      visible = !root.visible;
      source = "Logout.qml";
    }
  }
}
