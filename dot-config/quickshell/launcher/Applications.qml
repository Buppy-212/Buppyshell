pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import "fuzzysort.js" as Fuzzy
import "../services"

Item {
    id: appLauncher
    property real radius: Screen.height * 0.4
    property string title
    property string targetId
    anchors.fill: parent
    Keys.onEscapePressed: Hyprland.dispatch("global buppyshell:launcher")
    Keys.onPressed: inputField.focus = true
    Rectangle {
        anchors.centerIn: parent
        implicitWidth: parent.radius * 2
        implicitHeight: width
        radius: width
        color: Theme.color.black
        TextInput {
            id: inputField
            color: Theme.color.fg
            anchors.bottom: titleText.top
            anchors.left: parent.left
            anchors.right: parent.right
            font.family: Theme.font.family.mono
            font.pointSize: Theme.font.size.extraLarge
            horizontalAlignment: Text.AlignHCenter
            Keys.onReturnPressed: {
              Hyprland.dispatch("global buppyshell:launcher");
              Quickshell.execDetached(["uwsm", "app", "--", `${appLauncher.targetId}.desktop`])
            }
            focus: true
            font.bold: true
        }
        Text {
            id: titleText
            wrapMode: Text.Wrap
            anchors.centerIn: parent
            color: Theme.color.accent
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
            readonly property var fuzzy: Fuzzy.single(inputField.text, modelData.name)
            x: parent.width / 2 + appLauncher.radius * Math.cos(2 * Math.PI * (index - 2) / rep.count) - width / 2
            y: parent.height / 2 + appLauncher.radius * Math.sin(2 * Math.PI * (index - 2) / rep.count) - height / 2
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onFocusChanged: inputField.focus ? appLauncher.title = fuzzy.target : appLauncher.title = modelData.name
            focusPolicy: Qt.StrongFocus
            focus: {
              if (fuzzy?.target){
                appLauncher.title = fuzzy.target
                appLauncher.targetId = modelData.id;
                return !inputField.focus
              }
            }
            visible: !inputField.text || fuzzy
            onEntered: {
                focus = true;
                appLauncher.title = modelData.name;
            }
            onClicked: {
                console.log(modelData.id);
                Hyprland.dispatch("global buppyshell:launcher");
                Quickshell.execDetached(["uwsm", "app", "--", `${modelData.id}.desktop`]);
            }
            Keys.onReturnPressed: {
                Hyprland.dispatch("global buppyshell:launcher");
                Quickshell.execDetached(["uwsm", "app", "--", `${modelData.id}.desktop`]);
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
