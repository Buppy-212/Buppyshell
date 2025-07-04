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
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"
    visible: root.visible
    anchors {
      top: true
      right: true
      bottom: true
      left: true
    }
    margins {
      top: Theme.blockHeight
      left: Theme.blockWidth
      right: Theme.blockWidth
    }
    Rectangle {
      anchors.fill: parent
      color: "#aa222436"
      radius: Theme.rounding
      Loader {
        id: loader;
        focus: true
        anchors.fill: parent
        source: "Applications.qml";
      }
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
