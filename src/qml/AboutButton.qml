import QtQuick.Controls 2.15

RoundButton {
    text: "About"

    font.pixelSize: height / 4

    onClicked: aboutDialog.open()
}
