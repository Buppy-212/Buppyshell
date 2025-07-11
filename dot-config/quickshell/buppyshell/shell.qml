//@ pragma UseQApplication

import Quickshell
import "notifications"
import "bar"
// import "barV2"
import "background"
import "lockscreen"
import "sliders"
import "launcher"
import "sidebar"

ShellRoot {
    Bar {}
    Background {}
    Popup {}
    Lockscreen {}
    Sliders {
        isVolume: false
        isMic: false
    }
    Launcher {}
    Sidebar {}
}
