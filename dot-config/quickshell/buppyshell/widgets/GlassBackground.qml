import QtQuick
import qs.services
import qs.services.wallpaper

Image {
    id: root

    asynchronous: true
    fillMode: Image.PreserveAspectCrop
    source: Wallpapers.current
    visible: false

    Rectangle {
        anchors.fill: parent
        color: Theme.color.bg
        opacity: 0.85
    }
}
