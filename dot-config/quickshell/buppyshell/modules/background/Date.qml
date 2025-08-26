import QtQuick
import qs.services

Item {
    id: root

    readonly property string date: Time.date
    readonly property string day: Time.day
    readonly property string time: Time.time

    onDateChanged: shortDate.requestPaint()
    onDayChanged: day.requestPaint()
    onTimeChanged: time.requestPaint()

    Canvas {
        id: shortDate

        implicitHeight: parent.height / 2
        implicitWidth: parent.width
        transform: Rotation {
            origin.x: 0
            origin.y: shortDate.height / 2
            angle: 40
            axis.x: -1
            axis.y: 1
            axis.z: 0
        }
        onPaint: {
            var ctx = getContext("2d");
            ctx.font = `900 ${shortDate.height * 0.8}px '${Theme.font.family.sans}'`;
            ctx.fillStyle = Theme.color.fg;
            ctx.lineWidth = shortDate.height / 5;
            ctx.clearRect(0, 0, width, height);
            ctx.strokeText(root.date, shortDate.height / 6, shortDate.height * 0.8);
            ctx.fillText(root.date, shortDate.height / 6, shortDate.height * 0.8);
        }
    }
    Canvas {
        id: day

        y: parent.height * 0.35
        implicitHeight: parent.height / 4
        implicitWidth: parent.width
        transform: Rotation {
            origin.x: 0
            origin.y: 0
            angle: 45
            axis.x: -1
            axis.y: 1
            axis.z: 0
        }
        onPaint: {
            var ctx = getContext("2d");
            ctx.font = `900 ${day.height * 0.8}px '${Theme.font.family.sans}'`;
            ctx.fillStyle = Theme.color.fg;
            ctx.lineWidth = day.height / 5;
            ctx.clearRect(0, 0, width, height);
            ctx.strokeText(root.day, day.height / 5, day.height * 0.7);
            ctx.fillText(root.day, day.height / 5, day.height * 0.7);
        }
    }
    Canvas {
        id: time

        x: parent.height / 2
        y: parent.height * 0.42
        implicitHeight: parent.height / 5
        implicitWidth: parent.width
        transform: Rotation {
            origin.x: 0
            origin.y: 0
            angle: 25
            axis.x: 1
            axis.y: 1
            axis.z: -1
        }
        onPaint: {
            var ctx = getContext("2d");
            ctx.font = `900 ${time.height * 0.8}px '${Theme.font.family.mono}'`;
            ctx.fillStyle = Theme.color.fg;
            ctx.lineWidth = time.height / 5;
            ctx.clearRect(0, 0, width, height);
            ctx.strokeText(root.time, time.height / 8, time.height * 0.7);
            ctx.fillText(root.time, time.height / 8, time.height * 0.7);
        }
    }
}
