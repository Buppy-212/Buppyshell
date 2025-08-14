import QtQuick
import qs.services
import qs.widgets

StyledTextField {
    required property list<Item> forwardTargets
    focus: true
    onVisibleChanged: text = ""
    Keys.forwardTo: forwardTargets
    Keys.onEscapePressed: {
        GlobalState.launcher = false;
    }
    Keys.onPressed: event => {
        if (event.key == Qt.Key_F && event.modifiers & Qt.ControlModifier) {
            var index = GlobalState.launcherModule;
            index += 1;
            if (index >= 3) {
                index = 0;
            }
            GlobalState.launcherModule = index;
        }
    }
}
