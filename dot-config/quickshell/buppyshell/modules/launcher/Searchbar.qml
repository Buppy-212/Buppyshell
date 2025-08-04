import QtQuick
import qs.services
import qs.widgets

Item {
    id: root
    required property list<Item> forwardTargets
    property string search: input.text
    Rectangle {
        anchors {
            fill: parent
            leftMargin: parent.width / 3
            rightMargin: parent.width / 3
        }
        radius: height / 2
        color: Theme.color.bgalt
        StyledTextInput {
            id: input
            clip: true
            focus: true
            anchors.fill: parent
            font.pixelSize: parent.height / 2
            onVisibleChanged: text = ""
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
