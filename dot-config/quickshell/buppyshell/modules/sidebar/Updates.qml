import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.services.updates
import qs.widgets

ColumnLayout {
    id: root

    spacing: 0

    Header {
        title: "Updates"
        Layout.fillWidth: true
        rightButtonText: Updates.updates.length ? "" : ""
        function rightButtonTapped(): void {
            GlobalState.sidebar = false
            Quickshell.execDetached(["floatty", "update", "tmux"]);
        }
    }

    StyledListView {
        id: listView

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.rightMargin: root.width / 16
        Layout.leftMargin: root.width / 16
        currentIndex: -1
        model: Updates.updates
        delegate: StyledText {
            required property string modelData

            width: listView.width
            height: Theme.doubledBlockHeight
            text: modelData
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.font.size.large
            fontSizeMode: Text.Fit
        }
    }
}
