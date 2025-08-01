import QtQuick 2.9
import qs.services

Item {
    id: root

    property int size: 25
    property color color: Theme.color.black

    onColorChanged: {
        canvas.requestPaint();
    }

    readonly property QtObject cornerEnum: QtObject {
        id: cornerEnum
        readonly property int topLeft: 0
        readonly property int topRight: 1
        readonly property int bottomLeft: 2
        readonly property int bottomRight: 3
    }

    property int corner: cornerEnum.topLeft // Default to TopLeft

    width: size
    height: size

    Canvas {
        id: canvas

        anchors.fill: parent
        antialiasing: true

        onPaint: {
            var ctx = getContext("2d");
            var r = root.size;

            ctx.beginPath();
            switch (root.corner) {
            case cornerEnum.topLeft:
                ctx.arc(r, r, r, Math.PI, 3 * Math.PI / 2);
                ctx.lineTo(0, 0);
                break;
            case cornerEnum.topRight:
                ctx.arc(0, r, r, 3 * Math.PI / 2, 2 * Math.PI);
                ctx.lineTo(r, 0);
                break;
            case cornerEnum.bottomLeft:
                ctx.arc(r, 0, r, Math.PI / 2, Math.PI);
                ctx.lineTo(0, r);
                break;
            case cornerEnum.bottomRight:
                ctx.arc(0, 0, r, 0, Math.PI / 2);
                ctx.lineTo(r, r);
                break;
            }
            ctx.closePath();
            ctx.fillStyle = root.color;
            ctx.fill();
        }
    }
}
