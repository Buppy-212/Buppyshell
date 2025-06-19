import Quickshell
import QtQuick
import "root:/services"
import "root:/windows"

PanelWindow {
  id: notificationPopup
  property var currentNotification: null
  anchors {
    top: true
    right: true
  }
  margins {
    top: 4
    right: 4
  }
  Timer {
    id: timeoutTimer
    interval: 3000
    running: currentNotification !== null
    onTriggered: {
      if (currentNotification) {
        currentNotification.expire()
        currentNotification = null
        visible = false
      }
    }
  }
  function showNotification(notification) {
    currentNotification = notification
    visible = true
    timeoutTimer.restart()
  }
  color: "transparent"
  exclusiveZone: 0  
  implicitWidth: rect.width
  implicitHeight: rect.height
  visible: false
  Rectangle {
    id: rect
    implicitWidth: 400
    implicitHeight: 100
    color: Theme.color.bg
    radius: Theme.rounding
    border.width: 2
    border.color: Theme.color.blue
    Row {
      x: 16
      anchors.verticalCenter: parent.verticalCenter
      Image {
        source: currentNotification?.appIcon ?? ""
        width: 48
        height: 48
        visible: source !== ""
      }
      Column {
        anchors.verticalCenter: parent.verticalCenter
        Text {
          id: summary
          text: currentNotification?.summary ?? ""
          font.pointSize: Theme.font.size.large
          font.bold: true
          color: Theme.color.fg
        }
        Text {
          id: body
          text: currentNotification?.body ?? ""
          font.pointSize: Theme.font.size.normal
          color: Theme.color.fg
        }
      }
      Image {
        source: currentNotification?.image ?? ""
        width: 48
        height: 48
        visible: source !== ""
      }
    }
    MouseArea {  
      anchors.fill: parent  
      cursorShape: Qt.PointingHandCursor
      onClicked:{ 
        currentNotification.dismiss()
        currentNotification = null
        notificationPopup.visible = false
      }
    } 
  }
}
