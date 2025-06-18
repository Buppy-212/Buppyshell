pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property Color color: Color {}
  readonly property int rounding: 8
  readonly property int border: 4
  readonly property Font font: Font {}
  readonly property Anim anim: Anim {}
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
  component AnimCurves: QtObject {
    readonly property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
    readonly property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
    readonly property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
    readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
    readonly property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
    readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
    readonly property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.9, 1, 1]
    readonly property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
    readonly property list<real> expressiveEffects: [0.34, 0.8, 0.34, 1, 1, 1]
  }

  component AnimDurations: QtObject {
    readonly property int small: 200
    readonly property int normal: 400
    readonly property int large: 600
    readonly property int extraLarge: 1000
    readonly property int expressiveFastSpatial: 350
    readonly property int expressiveDefaultSpatial: 500
    readonly property int expressiveEffects: 200
  }

  component Anim: QtObject {
    readonly property AnimCurves curves: AnimCurves {}
    readonly property AnimDurations durations: AnimDurations {}
  }
}
