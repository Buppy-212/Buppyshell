import QtQuick
import qs.services
import qs.widgets

Item {
    id: root
    implicitHeight: Theme.blockHeight * 2
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
        font.pixelSize: height * 0.75
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
        font.pixelSize: height * 0.75
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
        font.pixelSize: height * 0.75
        visible: text
    }
}
