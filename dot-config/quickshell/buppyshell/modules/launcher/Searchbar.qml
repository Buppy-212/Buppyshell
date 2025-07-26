import QtQuick
import qs.services

Item {
    id: root
    required property list<var> forwardTargets
    property string search: input.text
    Rectangle {
        implicitWidth: Screen.width / 3
        implicitHeight: Theme.height.doubleBlock
        radius: Theme.radius.large
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
            font.pointSize: Theme.font.size.normal
            font.family: Theme.font.family.mono
            font.bold: true
            Keys.forwardTo: root.forwardTargets
            Keys.onPressed: event => {
                if (event.key == Qt.Key_F && event.modifiers & Qt.ControlModifier) {
                    GlobalState.launcherModule += 1;
                    if (GlobalState.launcherModule >= forwardTargets.length) {
                        GlobalState.launcherModule = 0;
                    }
                }
            }
        }
    }
}
