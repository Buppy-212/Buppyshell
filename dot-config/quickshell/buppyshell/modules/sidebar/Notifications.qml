pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import Quickshell.Hyprland
import qs.services
import qs.widgets
import qs.modules.notifications

ColumnLayout {
    Keys.forwardTo: [notificationList]
    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_D:
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
        Layout.fillWidth: true
        title: "Notifications"
        rightButtonText: "󰆴"
        function rightButtonTapped(): void {
            Hyprland.dispatch("global buppyshell:clearNotifs");
        }
    }
    StyledListView {
        id: notificationList
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.rightMargin: 36
        Layout.bottomMargin: 36
        Layout.leftMargin: 36
        spacing: 2
        clip: true
        model: notificationServer.trackedNotifications
        delegate: Content {
            id: content
            required property Notification modelData
            border.color: ListView.isCurrentItem ? Theme.color.red : Theme.color.blue
            implicitWidth: notificationList.width
            notification: modelData
        }
    }
}
