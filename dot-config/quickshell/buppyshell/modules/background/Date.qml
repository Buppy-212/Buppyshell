import QtQuick
import qs.services

Canvas {
    id: root

    readonly property string date: Time.date
    readonly property string day: Time.day
    readonly property string time: Time.time

    onTimeChanged: requestPaint()
    onPaint: {
        var ctx = getContext("2d");
        ctx.font = `900 ${height * 0.4}px '${Theme.font.family.sans}'`;
        ctx.fillStyle = Theme.color.fg;
        ctx.lineWidth = height / 10;
        ctx.resetTransform()
        ctx.clearRect(0, 0, width, height);
        ctx.setTransform(0.9, -0.155, -0.2, 1, height * 0.07, height*0.5);
        ctx.strokeText(root.date, 0, 0);
        ctx.fillText(root.date, 0, 0);
        ctx.setTransform(0.4, -0.08, -0.15, 0.5, height * 0.01, height*0.65);
        ctx.strokeText(root.day, 0, 0);
        ctx.fillText(root.day, 0, 0);
        ctx.font = `900 ${height * 0.4}px '${Theme.font.family.mono}'`;
        ctx.setTransform(0.32, -0.07, 0.1, 0.32, height * 0.7, height*0.7);
        ctx.strokeText(root.time, 0, 0);
        ctx.fillText(root.time, 0, 0);
    }
}
