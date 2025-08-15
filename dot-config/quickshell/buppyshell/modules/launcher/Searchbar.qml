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
        if (event.modifiers === Qt.ControlModifier) {
            switch (event.key) {
            case Qt.Key_F:
                var index = GlobalState.launcherModule;
                index += 1;
                if (index >= 3) {
                    index = 0;
                }
                GlobalState.launcherModule = index;
                break;
            case Qt.Key_C:
                GlobalState.launcher = false;
                break;
            case Qt.Key_Semicolon:
                GlobalState.launcher = false;
                break;
            }
        }
    }
}
