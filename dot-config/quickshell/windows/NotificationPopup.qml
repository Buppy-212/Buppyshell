import Quickshell
import Quickshell.Wayland
import QtQuick
import "root:/modules/notifications"

PanelWindow {
  id: notificationPopup
  property var currentNotification: null
  anchors {
    top: true
    right: true
  }
  margins {
    top: 2
    right: 2
  }
  Timer {
    id: timeoutTimer
    interval: 3000
    running: currentNotification !== null
    onTriggered: {
      if (currentNotification) {
        currentNotification = null
      } 
    }
  }
  color: "transparent"
  exclusiveZone: 0  
  implicitWidth: content.width
  implicitHeight: content.height
  visible: currentNotification === null ? false : true
  WlrLayershell.namespace: "buppyshell:notification"
  WlrLayershell.layer: WlrLayer.Overlay
  Content {id: content; notification: currentNotification}
}
