pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property Color color: Color {}
    readonly property int border: 2
    readonly property Font font: Font {}
    readonly property IconSize iconSize: IconSize {}
    readonly property Margin margin: Margin {}
    readonly property Height height: Height {}
    readonly property Width width: Width {}
    readonly property Radius radius: Radius {}
    property QtObject animation
    property QtObject animationCurves

    component Radius: QtObject {
        readonly property int normal: 8
        readonly property int normalAdjusted: 11
        readonly property int medium: 16
        readonly property int large: 32
    }

    component Height: QtObject {
        readonly property int block: 24
        readonly property int doubleBlock: 48
        readonly property int notification: 80
    }

    component Width: QtObject {
        readonly property int block: 30
    }

    component Margin: QtObject {
        readonly property int tiny: 2
        readonly property int small: 4
        readonly property int medium: 8
        readonly property int large: 16
    }

    component IconSize: QtObject {
        readonly property int small: 30
        readonly property int medium: 48
        readonly property int big: 64
        readonly property int large: 96
    }

    component Color: QtObject {
        readonly property string bg: "#222436"
        readonly property string bgTranslucent: "#aa222436"
        readonly property string bgalt: "#2a2c3d"
        readonly property string bgdark: "#1e2030"
        readonly property string fg: "#e9e9ed"
        readonly property string grey: "#313345"
        readonly property string red: "#ff757f"
        readonly property string orange: "#ff966c"
        readonly property string yellow: "#ffc777"
        readonly property string green: "#c3e88d"
        readonly property string cyan: "#86e1fc"
        readonly property string blue: "#82aaff"
        readonly property string accent: "#589ed7"
        readonly property string magenta: "#c099ff"
        readonly property string black: "#1b1d2b"
    }
    component FontFamily: QtObject {
        readonly property string sans: "Adwaita Sans"
        readonly property string mono: "JetBrainsMono Nerd Font Propo"
        readonly property string material: "Material Symbols Rounded"
        readonly property string handwritten: "Indie Flower"
    }
    component FontSize: QtObject {
        readonly property int normal: 17
        readonly property int medium: 20
        readonly property int large: 21
        readonly property int doubled: 34
        readonly property int extraLarge: 48
        readonly property int huge: 56
    }
    component Font: QtObject {
        readonly property FontFamily family: FontFamily {}
        readonly property FontSize size: FontSize {}
    }

    animationCurves: QtObject {
        id: animationCurves
        readonly property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.90, 1, 1] // Default, 350ms
        readonly property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1.00, 1, 1] // Default, 500ms
        readonly property list<real> expressiveSlowSpatial: [0.39, 1.29, 0.35, 0.98, 1, 1] // Default, 650ms
        readonly property list<real> expressiveEffects: [0.34, 0.80, 0.34, 1.00, 1, 1] // Default, 200ms
        readonly property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
        readonly property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
        readonly property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
        readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
        readonly property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
        readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
    }

    animation: QtObject {
        property QtObject elementMove: QtObject {
            id: elementMove
            property int duration: 500
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.expressiveDefaultSpatial
            property int velocity: 650
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: elementMove.duration
                    easing.type: elementMove.type
                    easing.bezierCurve: elementMove.bezierCurve
                }
            }
            property Component colorAnimation: Component {
                ColorAnimation {
                    duration: elementMove.duration
                    easing.type: elementMove.type
                    easing.bezierCurve: elementMove.bezierCurve
                }
            }
        }
        property QtObject elementMoveEnter: QtObject {
            id: elementMoveEnter
            property int duration: 400
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.emphasizedDecel
            property int velocity: 650
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: elementMoveEnter.duration
                    easing.type: elementMoveEnter.type
                    easing.bezierCurve: elementMoveEnter.bezierCurve
                }
            }
        }
        property QtObject elementMoveExit: QtObject {
            id: elementMoveExit
            property int duration: 200
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.emphasizedAccel
            property int velocity: 650
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: elementMoveExit.duration
                    easing.type: elementMoveExit.type
                    easing.bezierCurve: elementMoveExit.bezierCurve
                }
            }
        }
        property QtObject elementMoveFast: QtObject {
            id: elementMoveFast
            property int duration: 200
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.expressiveEffects
            property int velocity: 850
            property Component colorAnimation: Component {
                ColorAnimation {
                    duration: elementMoveFast.duration
                    easing.type: elementMoveFast.type
                    easing.bezierCurve: elementMoveFast.bezierCurve
                }
            }
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: elementMoveFast.duration
                    easing.type: elementMoveFast.type
                    easing.bezierCurve: elementMoveFast.bezierCurve
                }
            }
        }
    }
}
