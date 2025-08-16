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
    Sidebar {}
    Launcher {}
    Popup {}
    Lockscreen {}
}
