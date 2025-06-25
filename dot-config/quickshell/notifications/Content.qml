import Quickshell
import QtQuick
import Quickshell.Services.Notifications
import "root:/services"
import "."

Rectangle {
  id: rect
  required property var notification
  implicitWidth: 420
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
      source: Quickshell.iconPath(notification?.appIcon, "preferences-desktop-notification-bell")
      width: 48
      height: 48
      visible: notification === null ? false : true
      anchors.verticalCenter: column.verticalCenter
    }
    Column {
      id: column
      width: image.visible ? 300 : 250
      height: (summary.height + body.height) *1.05
      anchors.verticalCenter: parent.verticalCenter
      Text {
        id: summary
        wrapMode: Text.Wrap
        width: column.width
        text: notification?.summary ?? ""
        font.pointSize: Theme.font.size.large
        font.bold: true
        color: Theme.color.fg
      }
      Text {
        id: body
        wrapMode: Text.Wrap
        width: column.width
        text: notification?.body ?? ""
        font.pointSize: Theme.font.size.normal
        color: Theme.color.fg
      }
    }
    Image {
      id: image
      source: notification?.image ?? ""
      width: 48
      height: 48
      visible: source !== ""
      anchors.verticalCenter: column.verticalCenter
    }
  }
  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    drag.target: parent;
    drag.axis: "XAxis"
    drag.minimumX: 0
    drag.maximumX: 450
    drag.filterChildren: true
    onReleased:{
      rect.x = 450
      notification.actions?.invoke()
    }
  }
  Behavior on x {
    NumberAnimation {
      duration: Theme.animation.elementMoveExit.duration
      easing.type: Theme.animation.elementMoveExit.type
      easing.bezierCurve: Theme.animation.elementMoveExit.bezierCurve
      onRunningChanged: {
        if (!running) {
          x = 0
          notification?.dismiss()
        }
      }
    }
  }
}
