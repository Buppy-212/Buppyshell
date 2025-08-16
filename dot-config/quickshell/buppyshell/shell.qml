//@ pragma UseQApplication

pragma ComponentBehavior: Bound
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
            Osd {
                modelData: scope.modelData
                source: Osd.Volume
            }
            LazyLoader {
                loading: true
                component: Sidebar {
                    modelData: scope.modelData
                }
            }
            LazyLoader {
                loading: true
                component: Launcher {
                    modelData: scope.modelData
                }
            }
        }
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
