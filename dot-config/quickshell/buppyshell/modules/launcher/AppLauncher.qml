pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

StyledListView {
    id: root

    required property string search

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
        implicitHeight: Theme.blockHeight * 4
        implicitWidth: root.width
        contentItem: RowLayout {
            anchors {
                fill: parent
                leftMargin: parent.width / 64
                topMargin: parent.height / 32
                bottomMargin: parent.height / 32
            }
            spacing: anchors.leftMargin

            IconImage {
                Layout.fillHeight: true
                Layout.preferredWidth: height
                source: Quickshell.iconPath(desktopEntry.modelData.icon)
            }

            StyledText {
                Layout.fillWidth: true
                Layout.fillHeight: true
                elide: Text.ElideRight
                text: modelData.name
                font.pixelSize: Theme.font.size.doubled
                color: desktopEntry.ListView.isCurrentItem ? Theme.color.accent : Theme.color.fg
                horizontalAlignment: Text.AlignLeft
            }
        }
    }
}
