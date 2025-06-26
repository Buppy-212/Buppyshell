import Quickshell
import QtQuick
import Quickshell.Services.Notifications
import "root:/services"
import "."

Rectangle {
  id: rect
  required property var notification
  implicitWidth: Theme.notification.width
  implicitHeight: row.height > Theme.notification.height - 20 ? row.height + 20 : Theme.notification.height
  color: Theme.color.bg
  radius: Theme.rounding
  border.width: Theme.border
  border.color: Theme.color.blue
  Row {
    id: row
    width: column.width
    height: column.height
    spacing: Theme.notification.margin
    x: Theme.notification.margin
    anchors.verticalCenter: parent.verticalCenter
    Image {
      source: Quickshell.iconPath(notification?.appIcon, "preferences-desktop-notification-bell")
      width: Theme.notification.iconSize
      height: Theme.notification.iconSize
      visible: notification === null ? false : true
      anchors.verticalCenter: column.verticalCenter
    }
    Column {
      id: column
      width: image.visible ? Theme.notification.width - (2 * Theme.notification.iconSize) : Theme.notification.width - Theme.notification.iconSize
      height: summary.height + body.height
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
      width: Theme.notifiction.iconSize
      height: Theme.notifiction.iconSize
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
    drag.maximumX: Theme.notification.sidebarWidth
    drag.filterChildren: true
    onReleased:{
      rect.x = Theme.notification.sidebarWidth
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
