//@ pragma UseQApplication

pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import "windows"

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: Bar {onRight: true}
    }
    Variants {
        model: Quickshell.screens
        delegate: Background {}
    }
    Variants {
        model: Quickshell.screens
        delegate: Osd {
            source: Osd.Volume
        }
    }
    Variants {
        model: Quickshell.screens
        delegate: Sidebar {}
    }
    Variants {
        model: Quickshell.screens
        delegate: Launcher {}
    }
    Popup {}
    LazyLoader {
        loading: true
        component: Lockscreen {}
    }
}
