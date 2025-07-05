import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import "root:/services"

Scope {
  id: root
  property bool visible: false
  PanelWindow {
    id: panel
    WlrLayershell.namespace: "buppyshell:launcher"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    exclusionMode: ExclusionMode.Ignore
    color: "#aa222436"
    visible: root.visible
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
      id: loader;
      focus: true
      anchors.fill: parent
      source: "";
    }
  }
  GlobalShortcut {
    name: "launcher"
    description: "Toggle application launcher"
    appid: "buppyshell"
    onPressed: {
      root.visible = !root.visible;
      loader.source = "Applications.qml";
    }
  }
  GlobalShortcut {
    name: "windows"
    description: "Toggle window switcher"
    appid: "buppyshell"
    onPressed: {
      root.visible = !root.visible;
      loader.source = "Windows.qml";
    }
  }
  GlobalShortcut {
    name: "logout"
    description: "Toggle logout menu"
    appid: "buppyshell"
    onPressed: {
      root.visible = !root.visible;
      loader.source = "Logout.qml";
    }
  }
}
