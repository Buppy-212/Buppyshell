import Quickshell
import QtQuick
import "../services"

PanelWindow {
    id: menuWindow
    anchors {
        top: true
        right: true
        bottom: true
    }
    margins {
        top: 2
        right: 2
        bottom: 2
    }
    exclusiveZone: 0
    color: "transparent"
    implicitWidth: 600
    visible: GlobalState.bluetooth || GlobalState.player
    mask: Region {
        item: GlobalState.bluetooth ? bluetooth : null
        Region {
            item: GlobalState.player ? player : null
        }
    }
    Column {
        anchors.fill: parent
        spacing: 2
        Bluetooth {
            id: bluetooth
            Behavior on visible {
                animation: Theme.animation.elementMove.numberAnimation.createObject(this)
            }
            Behavior on y {
                animation: Theme.animation.elementMove.numberAnimation.createObject(this)
            }
        }
        Player {
            id: player
            Behavior on visible {
                animation: Theme.animation.elementMove.numberAnimation.createObject(this)
            }
            Behavior on y {
                animation: Theme.animation.elementMove.numberAnimation.createObject(this)
            }
        }
    }
}
