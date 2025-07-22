//@ pragma UseQApplication

import Quickshell
import "windows"

ShellRoot {
    Bar {}
    Background {}
    Popup {}
    Lockscreen {}
    Sliders {
        source: Sliders.Source.Volume
    }
    Launcher {}
    Sidebar {}
}
