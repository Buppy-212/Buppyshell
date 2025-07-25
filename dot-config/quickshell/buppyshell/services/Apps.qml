pragma Singleton

import qs.utils
import Quickshell

Searcher {
    id: root
    key: "name"
    list: DesktopEntries.applications.values.filter(a => !a.noDisplay).sort((a, b) => a.name.localeCompare(b.name))
}
