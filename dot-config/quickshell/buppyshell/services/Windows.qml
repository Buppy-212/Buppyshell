pragma Singleton

import qs.utils
import Quickshell.Wayland

Searcher {
  id: root
  key: "title"
  list: ToplevelManager.toplevels.values
}
