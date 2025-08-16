//@ pragma UseQApplication

import Quickshell
import "windows"

ShellRoot {
    Variants {
        model: Quickshell.screens
        Scope {
            id: scope
            required property ShellScreen modelData
            LeftBar {
                modelData: scope.modelData
            }
            RightBar {
                modelData: scope.modelData
            }
            Background {
                modelData: scope.modelData
            }
            Sliders {
                modelData: scope.modelData
                source: Sliders.Source.Volume
            }
        }
    }
    LazyLoader {
        loading: true
        component: Sidebar {}
    }
    LazyLoader {
        loading: true
        component: Launcher {}
    }
    LazyLoader {
        loading: true
        component: Popup {}
    }
    LazyLoader {
        loading: true
        component: Lockscreen {}
    }
}
