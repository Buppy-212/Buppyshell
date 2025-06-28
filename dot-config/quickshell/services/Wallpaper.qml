pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property string path
  SocketServer {
    active: true
    path: "/tmp/wallpaper.sock"
    handler: Socket {
      parser: SplitParser {
        onRead: message => {root.path = "file:/" + message; connected = false}
      }
    }
  }
}
