import QtQuick
import qs.services
import qs.widgets

Item {
    id: root
    implicitHeight: Theme.doubledBlockHeight
    property alias title: title.text
    property alias leftButtonText: leftButton.text
    property alias leftButtonColor: leftButton.color
    property alias rightButtonText: rightButton.text
    property alias rightButtonColor: rightButton.color
    function leftButtonTapped(): void {
    }
    function rightButtonTapped(): void {
    }
    StyledButton {
        id: leftButton
        function tapped() {
            root.leftButtonTapped();
        }
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        implicitWidth: root.width / 8
        font.pixelSize: Theme.font.size.doubled
        visible: text
    }
    StyledText {
        id: title
        anchors {
            top: parent.top
            right: rightButton.left
            bottom: parent.bottom
            left: leftButton.right
        }
        font.pixelSize: Theme.font.size.doubled
        fontSizeMode: Text.Fit
    }
    StyledButton {
        id: rightButton
        function tapped() {
            root.rightButtonTapped();
        }
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }
        implicitWidth: root.width / 8
        font.pixelSize: Theme.font.size.doubled
        visible: text
    }
}
