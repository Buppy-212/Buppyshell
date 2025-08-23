pragma Singleton

import Quickshell

Singleton {
    id: root
    readonly property string timeGrid: Qt.formatDateTime(clock.date, "hh\nmm")
    readonly property string time: Qt.formatDateTime(clock.date, "hh:mm")
    readonly property string date: Qt.formatDateTime(clock.date, "d/M")
    readonly property string day: Qt.formatDateTime(clock.date, "dddd")
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
