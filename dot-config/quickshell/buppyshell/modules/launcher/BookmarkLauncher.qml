pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.services
import qs.widgets

StyledListView {
    id: root

    required property string search

    Keys.onReturnPressed: root.currentItem.tapped(undefined, Qt.LeftButton)
    Keys.onPressed: event => {
        if (event.modifiers === Qt.ControlModifier) {
            switch (event.key) {
            case Qt.Key_O:
                root.currentItem.tapped(undefined, Qt.RightButton);
                break;
            case Qt.Key_D:
                root.currentItem.tapped(undefined, Qt.MiddleButton);
                break;
            case Qt.Key_I:
                root.currentItem.tapped(undefined, Qt.LeftButton);
                break;
            }
        }
    }
    background: null
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
                Quickshell.execDetached(["uwsm", "app", "--", "zen-browser", "-new-window", bookmark.modelData.name]);
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
                margins: Theme.margin
            }
            elide: Text.ElideRight
            text: bookmark.modelData.name
            font.pixelSize: Theme.font.size.doubled
            color: bookmark.ListView.isCurrentItem ? Theme.color.accent : Theme.color.fg
            horizontalAlignment: Text.AlignLeft
        }
    }
}
