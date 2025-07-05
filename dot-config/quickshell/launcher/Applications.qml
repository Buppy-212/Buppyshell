pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import "../services"

Item {
    id: appLauncher
    property real radius: Screen.height / 3
    property string title
    anchors.fill: parent
    Keys.onEscapePressed: Hyprland.dispatch("global buppyshell:launcher")
    Rectangle {
        anchors.centerIn: parent
        implicitWidth: parent.radius * 2
        implicitHeight: width
        radius: width
        color: Theme.color.black
        Text {
            anchors.centerIn: parent
            wrapMode: Text.Wrap
            color: Theme.color.fg
            text: appLauncher.title
            font.family: Theme.font.family.mono
            font.pointSize: Theme.font.size.extraLarge
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
        }
    }
    Repeater {
        id: rep
        model: DesktopEntries.applications
        delegate: WrapperMouseArea {
            id: desktopEntry
            required property DesktopEntry modelData
            required property int index
            x: parent.width / 2 + appLauncher.radius * Math.cos(2 * Math.PI * (index - 2) / rep.count) - width / 2
            y: parent.height / 2 + appLauncher.radius * Math.sin(2 * Math.PI * (index - 2) / rep.count) - height / 2
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            focus: index ? false : true
            onFocusChanged: appLauncher.title = modelData.name
            focusPolicy: Qt.StrongFocus
            onEntered: {
                focus = true;
                appLauncher.title = modelData.name;
            }
            onClicked: {
                console.log(modelData.id);
                Hyprland.dispatch("global buppyshell:launcher");
                Hyprland.dispatch(`exec uwsm app -- ${modelData.id}.desktop`);
            }
            Keys.onReturnPressed: {
                Hyprland.dispatch("global buppyshell:launcher");
                Hyprland.dispatch(`exec uwsm app -- ${modelData.id}.desktop`);
            }
            Rectangle {
                id: rect
                implicitHeight: rep.count < 4 ? Screen.height / 4 : Screen.height / rep.count + Theme.blockHeight
                implicitWidth: implicitHeight
                color: desktopEntry.focus ? Theme.color.grey : "transparent"
                radius: Theme.rounding
                IconImage {
                    implicitSize: parent.height
                    source: Quickshell.iconPath(desktopEntry.modelData.icon)
                }
            }
        }
    }
}
