pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property Color color: Color {}
  readonly property int rounding: 8
  readonly property int border: 2
  readonly property Font font: Font {}
  property QtObject animation
  property QtObject animationCurves
  readonly property url wallpaper: "root:/assets/frieren.png"

  component Color: QtObject {
    readonly property string bg: "#222436"
    readonly property string fg: "#e9e9ed"
    readonly property string gray: "#313345"
    readonly property string red: "#ff757f"
    readonly property string orange: "#ff966c"
    readonly property string yellow: "#ffc777"
    readonly property string green: "#c3e88d"
    readonly property string cyan: "#86e1fc"
    readonly property string blue: "#82aaff"
    readonly property string darkblue: "#2d3f76"
    readonly property string magenta: "#c099ff"
    readonly property string black: "#1b1d2b"
  }
  component FontFamily: QtObject {
    readonly property string sans: "Adwaita Sans"
    readonly property string mono: "JetBrainsMono Nerd Font"
    readonly property string material: "Material Symbols Rounded"
    readonly property string serif: "Z003"
  }
  component FontSize: QtObject {
    readonly property int normal: 13
    readonly property int large: 15
    readonly property int extraLarge: 46
    readonly property int huge: 54
  }
  component Font: QtObject {
    readonly property FontFamily family: FontFamily {}
    readonly property FontSize size: FontSize {}
  }

  animationCurves: QtObject {
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
      property int duration: 500
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: animationCurves.expressiveDefaultSpatial
      property int velocity: 650
      property Component numberAnimation: Component {
        NumberAnimation {
          duration: root.animation.elementMove.duration
          easing.type: root.animation.elementMove.type
          easing.bezierCurve: root.animation.elementMove.bezierCurve
        }
      }
      property Component colorAnimation: Component {
        ColorAnimation {
          duration: root.animation.elementMove.duration
          easing.type: root.animation.elementMove.type
          easing.bezierCurve: root.animation.elementMove.bezierCurve
        }
      }
    }
    property QtObject elementMoveEnter: QtObject {
      property int duration: 400
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: animationCurves.emphasizedDecel
      property int velocity: 650
      property Component numberAnimation: Component {
        NumberAnimation {
          duration: root.animation.elementMoveEnter.duration
          easing.type: root.animation.elementMoveEnter.type
          easing.bezierCurve: root.animation.elementMoveEnter.bezierCurve
        }
      }
    }
    property QtObject elementMoveExit: QtObject {
      property int duration: 200
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: animationCurves.emphasizedAccel
      property int velocity: 650
      property Component numberAnimation: Component {
        NumberAnimation {
          duration: root.animation.elementMoveExit.duration
          easing.type: root.animation.elementMoveExit.type
          easing.bezierCurve: root.animation.elementMoveExit.bezierCurve
        }
      }
    }
    property QtObject elementMoveFast: QtObject {
      property int duration: 200
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: animationCurves.expressiveEffects
      property int velocity: 850
      property Component colorAnimation: Component { ColorAnimation {
        duration: root.animation.elementMoveFast.duration
        easing.type: root.animation.elementMoveFast.type
        easing.bezierCurve: root.animation.elementMoveFast.bezierCurve
      }}
      property Component numberAnimation: Component { NumberAnimation {
        duration: root.animation.elementMoveFast.duration
        easing.type: root.animation.elementMoveFast.type
        easing.bezierCurve: root.animation.elementMoveFast.bezierCurve
      }}
    }

    property QtObject clickBounce: QtObject {
      property int duration: 200
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: animationCurves.expressiveFastSpatial
      property int velocity: 850
      property Component numberAnimation: Component { NumberAnimation {
        duration: root.animation.clickBounce.duration
        easing.type: root.animation.clickBounce.type
        easing.bezierCurve: root.animation.clickBounce.bezierCurve
      }}
    }
    property QtObject scroll: QtObject {
      property int duration: 400
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: animationCurves.standardDecel
    }
    property QtObject menuDecel: QtObject {
      property int duration: 350
      property int type: Easing.OutExpo
    }
  }
}
