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
            property bool accepted
            clip: true
            onVisibleChanged: {
                if (accepted) {
                    text = "";
                    accepted = false;
                } else {
                    selectAll();
                }
            }
            onAccepted: accepted = true
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
        }
    }
}
