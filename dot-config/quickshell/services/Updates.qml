pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property int updates
  SocketServer {
    active: true
    path: "/tmp/updates.sock"
    handler: Socket {
      parser: SplitParser {
        onRead: message => {root.updates = message; connected = false}
      }
    }
  }
}
