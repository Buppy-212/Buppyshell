pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property Color color: Color {}
  readonly property int rounding: 6
  readonly property Font font: Font {}
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
  }
  component FontSize: QtObject {
    readonly property int normal: 13
    readonly property int large: 15
  }
  component Font: QtObject {
    readonly property FontFamily family: FontFamily {}
    readonly property FontSize size: FontSize {}
  }
}
