pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import qs.services
import qs.widgets
import qs.modules.notifications

ColumnLayout {
    id: root

    Keys.forwardTo: [notificationList]
    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_D:
            notificationList.currentItem.x = notificationList.width;
            break;
        case Qt.Key_C:
            header.rightButtonTapped();
            break;
        case Qt.Key_N:
            header.leftButtonTapped();
            break;
        case Qt.Key_Delete:
            notificationList.currentItem.x = notificationList.width;
            break;
        case Qt.Key_Return:
            notificationList.currentItem.modelData.actions?.invoke();
            break;
        }
    }
    spacing: 0

    NotificationServer {
        id: notificationServer
    }

    Header {
        id: header

        Layout.fillWidth: true
        title: "Notifications"
        leftButtonText: GlobalState.doNotDisturb ? "󰂠" : "󰂚"
        function leftButtonTapped(): void {
            GlobalState.doNotDisturb = !GlobalState.doNotDisturb;
        }
        rightButtonText: "󰆴"
        function rightButtonTapped(): void {
            for (var child in notificationList.contentItem.children) {
                notificationList.contentItem.children[child].x = notificationList.width;
            }
        }
    }

    StyledListView {
        id: notificationList

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.rightMargin: root.width / 16
        Layout.leftMargin: root.width / 16
        controlless: true
        spacing: 2
        model: notificationServer.trackedNotifications
        delegate: Content {
            id: content

            required property Notification modelData

            border.color: ListView.isCurrentItem || hovered ? Theme.color.red : Theme.color.blue
            implicitWidth: notificationList.width
            notification: modelData
        }
    }
}
