pragma ComponentBehavior: Bound

import QtQuick
import qs.services.bookmarks
import qs.services
import qs.widgets

StyledListView {
    id: root

    required property string search

    Keys.onReturnPressed: {
      if (root.currentItem) {
        root.currentItem.tapped(undefined, Qt.LeftButton)
      } else {
        Bookmarks.add(root.search)
        GlobalState.launcher = false;
      }
    }
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

        required property Bookmark modelData
        required property int index

        function tapped(pointEvent, button) {
            switch (button) {
            case Qt.LeftButton:
                bookmark.modelData.open();
                GlobalState.launcher = false;
                break;
            case Qt.MiddleButton:
                Bookmarks.remove(modelData);
                break;
            case Qt.RightButton:
                bookmark.modelData.openInNewWindow();
                GlobalState.launcher = false;
                break;
            }
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
            text: bookmark.modelData?.name ?? ""
            font.pixelSize: Theme.font.size.doubled
            color: bookmark.ListView.isCurrentItem ? Theme.color.accent : Theme.color.fg
            horizontalAlignment: Text.AlignLeft
        }
    }
}
