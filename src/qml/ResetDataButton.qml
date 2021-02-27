import QtQuick.Controls 2.15

RoundButton {
    text: "Reset all data"

    font.pixelSize: height / 4

    onClicked: {
        resetDataDialog.open()
    }
}
