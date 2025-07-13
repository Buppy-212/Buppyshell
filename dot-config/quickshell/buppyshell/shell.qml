//@ pragma UseQApplication

import Quickshell
import "windows"

ShellRoot {
    Bar {}
    Background {}
    Popup {}
    Lockscreen {}
    Sliders {
        source: Source.Volume
    }
    Launcher {}
    Sidebar {}
}
