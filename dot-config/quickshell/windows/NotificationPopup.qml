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
    implicitHeight: row.height > 60 ? row.height + 20 : 80
    color: Theme.color.bg
    radius: Theme.rounding
    border.width: 2
    border.color: Theme.color.blue
    Row {
      id: row
      width: column.width
      height: column.height
      spacing: 16
      x: 16
      anchors.verticalCenter: parent.verticalCenter
      Image {
        source: currentNotification === null ? "" : currentNotification.appIcon !== "" ? Quickshell.iconPath(currentNotification.appIcon) : ""
        width: 48
        height: 48
        visible: currentNotification === null ? "" : currentNotification.appIcon !== "" ? true : false
      }
      Column {
        id: column
        width: 320
        height: (summary.height + body.height) *1.05
        anchors.verticalCenter: parent.verticalCenter
        Text {
          id: summary
          wrapMode: Text.Wrap
          width: column.width
          text: currentNotification?.summary ?? ""
          font.pointSize: Theme.font.size.large
          font.bold: true
          color: Theme.color.fg
        }
        Text {
          id: body
          wrapMode: Text.Wrap
          width: column.width
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
