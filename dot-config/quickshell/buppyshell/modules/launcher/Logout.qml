pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.services
import qs.services.power
import qs.widgets

StyledListView {
    id: root

    required property string search

    Keys.onReturnPressed: root.currentItem.tapped()
    Keys.onPressed: event => {
        if (event.modifiers === Qt.ControlModifier && event.key === Qt.Key_O) {
            root.currentItem.tapped();
        }
    }
    background: null
    model: Power.query(root.search)
    delegate: StyledButton {
        id: powerOption

        required property PowerOption modelData
        required property int index

        function tapped(): void {
            powerOption.modelData.action();
            GlobalState.launcher = false;
        }
        function entered(): void {
            root.currentIndex = powerOption.index;
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

            Text {
                id: symbol

                Layout.fillHeight: true
                Layout.preferredWidth: height
                text: powerOption.modelData.icon
                font.family: Theme.font.family.material
                font.pixelSize: height
                color: powerOption.modelData.color
                verticalAlignment: Text.AlignVCenter
            }

            StyledText {
                text: powerOption.modelData.name
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pixelSize: Theme.font.size.doubled
                color: powerOption.ListView.isCurrentItem ? Theme.color.accent : Theme.color.fg
                horizontalAlignment: Text.AlignLeft
            }
        }
    }
}
