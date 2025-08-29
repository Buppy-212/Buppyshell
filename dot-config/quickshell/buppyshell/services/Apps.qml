pragma Singleton

import qs.utils
import Quickshell

Searcher {
    id: root
    key: "name"
    list: DesktopEntries.applications.values
}
