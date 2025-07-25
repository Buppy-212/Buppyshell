import QtQuick
import QtQuick.Layouts
import qs.modules.bar
import qs.services

Rectangle {
    id: leftRect
    color: Theme.color.black
    implicitHeight: parent.height
    implicitWidth: Theme.width.block
    ColumnLayout {
        anchors.fill: parent
        ColumnLayout {
            spacing: Theme.margin.tiny
            Layout.alignment: Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true
            Os {
                Layout.alignment: Qt.AlignTop
            }
            Workspaces {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
        Column {
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
            spacing: Theme.margin.tiny
            Inhibitor {}
            Battery {}
            Light {}
            Update {}
            Clock {}
            Power {}
        }
    }
}
