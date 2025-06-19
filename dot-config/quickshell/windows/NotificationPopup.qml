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
    implicitWidth: row.width*1.5 + 64 > 400 ? row.width*1.5 : 400
    implicitHeight: row.height*1.5 > 100 ? row.height*1.5 : 100
    color: Theme.color.bg
    radius: Theme.rounding
    border.width: 2
    border.color: Theme.color.blue
    Row {
      id: row
      width: column.width
      height: column.height
      x: 16
      anchors.verticalCenter: parent.verticalCenter
      Image {
        source: currentNotification?.appIcon ?? ""
        width: 48
        height: 48
        visible: source !== ""
      }
      Column {
        id: column
        width: summary.width > body.width ? summary.width : body.width
        height: summary.height + body.height
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
