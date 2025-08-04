import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.services

GridLayout {
    columns: 1
    columnSpacing: 0
    rows: 2
    rowSpacing: 0
    StyledText {
        Layout.fillWidth: true
        Layout.preferredHeight: Theme.height.doubleBlock
        text: "Network"
        font.pixelSize: Theme.font.size.doubled
    }
    Rectangle {
        id: networkWidget
        color: Theme.color.bgalt
        radius: Theme.radius.normal
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.rightMargin: 36
        Layout.bottomMargin: 36
        Layout.leftMargin: 36
    }
}
