pragma ComponentBehavior: Bound

import Quickshell
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
    model: Bookmarks.query(root.search)
    delegate: StyledButton {
        id: bookmark

        required property QtObject modelData
        required property int index

        function tapped(pointEvent, button) {
            switch (button) {
              case Qt.LeftButton:
              Quickshell.execDetached(["uwsm", "app", "--", "zen-browser", bookmark.modelData.name]);
              break;
              case Qt.MiddleButton:
              Quickshell.execDetached(["uwsm", "app", "--", "floatty", "nvim", `${Quickshell.env("XDG_STATE_HOME")}/bookmarks.txt`]);
              break;
              case Qt.RightButton:
              Quickshell.execDetached(["uwsm", "app", "--", "zen.desktop", bookmark.modelData.name]);
              break;
            }
            GlobalState.launcher = false;
        }
        function entered() {
            root.currentIndex = bookmark.index;
        }

        background: null
        implicitHeight: Theme.blockHeight * 4
        implicitWidth: root.width
        contentItem: StyledText {
            anchors {
                fill: parent
                leftMargin: parent.width / 64
                topMargin: parent.height / 32
                bottomMargin: parent.height / 32
            }
            elide: Text.ElideRight
            text: bookmark.modelData.name
            font.pixelSize: Theme.font.size.doubled
            color: bookmark.ListView.isCurrentItem ? Theme.color.accent : Theme.color.fg
            horizontalAlignment: Text.AlignLeft
        }
    }
}
