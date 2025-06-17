import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import "root:/services"

PanelWindow {
    // required property font custom_font
    required property color text_color
    property list<QtObject> notification_objects

    width: 500
    height: 600
    anchors.right: true
    anchors.top: true
    color: Theme.color.bg

    WlrLayershell.layer: WlrLayer.Overlay

    Rectangle {
        border.width: 2
        border.color: Theme.color.blue
        anchors.fill: parent
        color: "transparent"

        ColumnLayout {
            id: content
            anchors {
                left: parent.left
                leftMargin: 10
                right: parent.right
                rightMargin: 10
                top: parent.top
                topMargin: 10
            }

            RowLayout {
                Layout.fillWidth: true

                Text {
                    Layout.fillWidth: true
                    text: "Notifications:"
                    font.family: Theme.font.sans
                    font.pointSize: Theme.font.size.large
                    color: Theme.color.fg
                }

                Text {
                    text: "clear"
                    font.family: Theme.font.sans
                    font.pointSize: Theme.font.size.large
                    color: Theme.color.fg

                    TapHandler {
                        id: tapHandler
                        gesturePolicy: TapHandler.ReleaseWithinBounds
                        onTapped: {
                            server.trackedNotifications.values.forEach((notification) => {
                                notification.tracked = false
                            })
                            notification_objects.forEach((object) => {
                                object.destroy();
                            })
                            notification_objects = [];
                        }
                    }

                    HoverHandler {
                        id: mouse
                        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
    }

    NotificationServer {
        id: server
        onNotification: (notification) => {
            notification.tracked = true
            console.log(JSON.stringify(notification));
            var notification_component = Qt.createComponent("root:/modules/notifications/Notification.qml");
            var notification_object = notification_component
            .createObject(content, 
                {
                    id: notification.id,
                    body: notification.body,
                    summary: notification.summary,
                    color: Theme.color.fg,
                    margin: 10
                }
            )
            if (notification_object == null) {
                console.log("Error creating notification")
            } else {
                notification_objects.push(notification_object);
            }
        }
    }
}
