import QtQuick.Controls 2.15

RoundButton {
    height: mainWindow.height / 12
    width: height
    anchors.margins: 20
    anchors.bottom: parent.bottom
    anchors.right: parent.right

    text: "+"

    font.pixelSize: height / 2
}
