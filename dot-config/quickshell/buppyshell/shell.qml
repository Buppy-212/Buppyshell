//@ pragma UseQApplication

import Quickshell
import "notifications"
import "bar"
// import "barV2"
import "background"
import "lockscreen"
import "sliders"
import "launcher"
import "windows"

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
    Music {}
}
