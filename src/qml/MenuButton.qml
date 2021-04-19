import QtQuick.Controls 2.15

RoundButton {
    height: mainWindow.height / 12
    width: height
    z: 100
    anchors.margins: 20
    anchors.right: parent.right
    anchors.top: parent.top

    text: "≡"

    font.pixelSize: height / 2

    onClicked: menuPage.visible ? pageStack.pop() : pageStack.push(menuPage)
}
