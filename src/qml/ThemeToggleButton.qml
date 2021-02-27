import QtQuick.Controls 2.15

RoundButton {
    text: darkMode ? "Light mode" : "Dark mode"

    font.pixelSize: height / 4

    onClicked: darkMode = !darkMode
}
