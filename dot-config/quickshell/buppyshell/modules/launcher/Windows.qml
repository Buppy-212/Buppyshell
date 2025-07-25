pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import qs.services

ClippingRectangle {
    anchors.centerIn: parent
    radius: Theme.radius.normal
    implicitWidth: {
      if (windowList.count === 0) {
        return Theme.iconSize.large + Theme.margin.large
      }
      if (windowList.count * (Theme.iconSize.large + Theme.margin.medium) + Theme.margin.medium < Screen.width) {
        return windowList.count * (Theme.iconSize.large + Theme.margin.medium) + Theme.margin.medium
      }
      return Screen.width
    }
    implicitHeight: Theme.iconSize.large + Theme.height.block + 36 + 4 * Theme.margin.medium
    color: Theme.color.bg
    Keys.onEscapePressed: GlobalState.overlay = false
    Column {
        anchors.fill: parent
        anchors.margins: Theme.margin.medium
        spacing: Theme.margin.medium
        ClippingRectangle {
            radius: Theme.radius.large
            implicitHeight: 36
            implicitWidth: parent.width
            color: Theme.color.grey
            TextInput {
              id: input
              onVisibleChanged: text = ""
              anchors.fill: parent
              verticalAlignment: Text.AlignVCenter
              leftPadding: Theme.margin.large
              rightPadding: Theme.margin.large
              focus: visible
              color: Theme.color.fg
              font.pointSize: Theme.font.size.normal
              font.family: Theme.font.family.mono
              font.bold: true
              Keys.onPressed: event => {
                switch (event.key) {
                  case Qt.Key_Tab :
                  windowList.incrementCurrentIndex()
                  break;
                  case Qt.Key_Backtab :
                  windowList.decrementCurrentIndex()
                  break;
                  case Qt.Key_Delete:
                  modelData.close();
                  break;
                  case Qt.Key_Return:
                  Hyprland.dispatch(`focuswindow address:0x${windowList.currentItem.modelData.HyprlandToplevel.handle.address}`);
                  GlobalState.overlay = false;
                  break;
                }
              }
            }
          }
        ListView {
            id: windowList
            model: Windows.query(input.text)
            orientation: ListView.Horizontal
            spacing: Theme.margin.medium
            snapMode: ListView.SnapToItem
            highlight: Rectangle {
                color: Theme.color.grey
                radius: Theme.radius.normal
            }
            keyNavigationWraps: true
            highlightFollowsCurrentItem: true
            highlightMoveDuration: 0
            width: parent.width
            height: Theme.iconSize.large
            displaced: Transition {
                NumberAnimation {
                    property: "x"
                    duration: Theme.animation.elementMoveFast.duration
                    easing.type: Theme.animation.elementMoveFast.type
                    easing.bezierCurve: Theme.animation.elementMoveFast.bezierCurve
                }
            }
            delegate: WrapperMouseArea {
                id: windowDelegate
                required property Toplevel modelData
                required property int index
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: mouse => {
                    switch (mouse.button) {
                    case Qt.LeftButton:
                        Hyprland.dispatch(`focuswindow address:0x${modelData.HyprlandToplevel.handle.address}`);
                        GlobalState.overlay = false;
                        break;
                    case Qt.MiddleButton:
                        modelData.close();
                        break;
                    case Qt.RightButton:
                        Hyprland.dispatch(`movetoworkspace ${Hyprland.focusedWorkspace.id}, address:0x${modelData.HyprlandToplevel.handle.address}`);
                        GlobalState.overlay = false;
                        break;
                    }
                }
                onEntered: windowList.currentIndex = windowDelegate.index
                Rectangle {
                    implicitHeight: Theme.iconSize.large
                    implicitWidth: implicitHeight
                    color: windowDelegate.ListView.isCurrentItem ? Theme.color.grey : "transparent"
                    radius: Theme.radius.normal
                    IconImage {
                        implicitSize: Theme.iconSize.large
                        source: {
                            if (windowDelegate.modelData?.appId.startsWith("steam_app")) {
                                return Quickshell.iconPath("input-gaming");
                            } else if (windowDelegate.modelData?.appId == "") {
                                return (Quickshell.iconPath("image-loading"));
                            } else {
                                return Quickshell.iconPath(windowDelegate.modelData?.appId.toLowerCase() ?? "image-loading", windowDelegate.modelData?.appId);
                            }
                        }
                    }
                }
            }
        }
        Text {
            height: Theme.height.block
            width: parent.width
            text: windowList.currentItem?.modelData.title ?? ""
            color: Theme.color.fg
            font {
                family: Theme.font.family.mono
                pointSize: Theme.font.size.normal
                bold: true
            }
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
