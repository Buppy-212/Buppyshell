//@ pragma UseQApplication

import Quickshell
import "notifications"
import "bar"
import "background"
import "lockscreen"
import "sliders"
import "launcher"

ShellRoot {
    Bar {}
    Background {}
    Popup {}
    Lockscreen {}
    Sliders {
        isVolume: false
        isMic: false
    }
    Launcher {
        visible: false
        source: ""
    }
}
