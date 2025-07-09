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
    Sidebar {}
    Sliders {
        isVolume: false
        isMic: false
    }
    Launcher {}
}
