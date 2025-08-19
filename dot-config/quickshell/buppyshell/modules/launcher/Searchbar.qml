import QtQuick
import qs.services
import qs.widgets

StyledTextField {
    onVisibleChanged: text = ""
    Keys.onEscapePressed: {
        GlobalState.launcher = false;
    }
    Keys.onTabPressed: {
        var i = GlobalState.launcherModule;
        i += 1;
        if (i > 3) {
            i = 0;
        }
        GlobalState.launcherModule = i;
    }
    Keys.onBacktabPressed: {
        var i = GlobalState.launcherModule;
        i -= 1;
        if (i < 0) {
            i = 3;
        }
        GlobalState.launcherModule = i;
    }
    Keys.onPressed: event => {
        if (event.modifiers === Qt.ControlModifier) {
            switch (event.key) {
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
