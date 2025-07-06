pragma Singleton

import Quickshell

Singleton {
  id: root
  readonly property string time: Qt.formatDateTime(clock.date, "hh\nmm")
  readonly property string lockTime: Qt.formatDateTime(clock.date, "hh:mm")
  readonly property string day: Qt.formatDateTime(clock.date, "dddd")
  readonly property string date: Qt.formatDateTime(clock.date, "d MMM yyyy")
  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
