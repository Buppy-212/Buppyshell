pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

StyledGridView {
    id: root
    required property string search
    cellHeight: height / 5
    cellWidth: width / 9
    background: null
    Keys.onReturnPressed: root.currentItem.tapped()
    Keys.onPressed: event => {
        if (event.modifiers === Qt.ControlModifier && event.key === Qt.Key_O) {
            root.currentItem.tapped();
        }
    }
    model: Apps.query(root.search)
    delegate: StyledButton {
        id: desktopEntry
        required property DesktopEntry modelData
        required property int index
        function tapped() {
            Quickshell.execDetached(["uwsm", "app", "--", `${desktopEntry.modelData.id}.desktop`]);
            GlobalState.launcher = false;
        }
        function entered() {
            root.currentIndex = desktopEntry.index;
        }
        background: null
        implicitWidth: root.cellWidth
        implicitHeight: root.cellHeight
        contentItem: ColumnLayout {
            spacing: 0
            anchors {
                fill: parent
                topMargin: parent.height / 20
                rightMargin: parent.width / 20
                bottomMargin: parent.height / 20
                leftMargin: parent.width / 20
            }
            IconImage {
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.6
                Layout.preferredWidth: height
                source: Quickshell.iconPath(desktopEntry.modelData.icon)
            }
            StyledText {
                Layout.fillWidth: true
                Layout.fillHeight: true
                anchors.fill: undefined
                text: modelData.name
                font.pixelSize: height / 4
                wrapMode: Text.Wrap
                color: desktopEntry.GridView.isCurrentItem ? Theme.color.accent : Theme.color.fg
            }
        }
    }
}
