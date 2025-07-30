import QtQuick
import qs.services

Item {
    id: root
    required property list<Item> forwardTargets
    property string search: input.text
    Rectangle {
        implicitWidth: parent.width / 3
        implicitHeight: parent.height / 2
        radius: height / 2
        color: Theme.color.bgalt
        anchors.centerIn: parent
        TextInput {
            id: input
            clip: true
            onVisibleChanged: text = ""
            focus: true
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            leftPadding: Theme.margin.large
            rightPadding: Theme.margin.large
            color: Theme.color.fg
            font {
                pixelSize: parent.height / 2
                family: Theme.font.family.mono
                bold: true
            }
            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }
            Keys.forwardTo: root.forwardTargets
            Keys.onPressed: event => {
                if (event.key == Qt.Key_F && event.modifiers & Qt.ControlModifier) {
                    GlobalState.launcherModule += 1;
                    if (GlobalState.launcherModule >= 3) {
                        GlobalState.launcherModule = 0;
                    }
                }
            }
        }
    }
}
