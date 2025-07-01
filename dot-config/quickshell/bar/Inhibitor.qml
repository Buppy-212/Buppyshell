import "root:/services"

Block {
  SymbolText {
    text: Idle.active ? "visibility_off" : "visibility"
    color: Theme.color.cyan
  }
  MouseBlock {
    id: mouse
    onClicked: Idle.toggleInhibitor()
  }
}
