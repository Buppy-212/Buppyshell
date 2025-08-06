import QtQuick
import qs.services
import qs.widgets

StyledTextField {
    required property list<Item> forwardTargets
    clip: true
    focus: true
    onVisibleChanged: text = ""
    Keys.forwardTo: forwardTargets
    Keys.onPressed: event => {
        if (event.key == Qt.Key_F && event.modifiers & Qt.ControlModifier) {
            GlobalState.launcherModule += 1;
            if (GlobalState.launcherModule >= 3) {
                GlobalState.launcherModule = 0;
            }
        }
    }
}
