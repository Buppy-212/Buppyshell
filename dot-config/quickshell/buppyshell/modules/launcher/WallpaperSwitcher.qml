pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.services.wallpaper
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
            case Qt.Key_I:
                root.currentItem.tapped(undefined, Qt.LeftButton);
                break;
            }
        }
    }
    background: null
    model: Wallpapers.query(root.search)
    delegate: StyledButton {
        id: wallpaper

        required property Wallpaper modelData
        required property int index

        function tapped(pointEvent, button) {
            switch (button) {
            case Qt.LeftButton:
                modelData.select();
                break;
            case Qt.RightButton:
                modelData.greeter();
                break;
            }
            GlobalState.launcher = false;
        }

        function entered() {
            root.currentIndex = wallpaper.index;
        }

        background: null
        implicitHeight: Theme.blockHeight * 4
        implicitWidth: root.width
        contentItem: RowLayout {
            anchors {
                fill: parent
                margins: Theme.margin
            }
            spacing: Theme.margin

            Image {
                Layout.fillHeight: true
                Layout.preferredWidth: height * 16 / 9
                asynchronous: true
                fillMode: Image.PreserveAspectCrop
                source: wallpaper.modelData?.url ?? ""
            }

            StyledText {
                Layout.fillHeight: true
                Layout.fillWidth: true
                elide: Text.ElideRight
                text: wallpaper.modelData?.name ?? ""
                font.pixelSize: Theme.font.size.doubled
                color: wallpaper.ListView.isCurrentItem ? Theme.color.accent : Theme.color.fg
                horizontalAlignment: Text.AlignLeft
            }
        }
    }
}
