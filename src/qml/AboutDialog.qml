import QtQuick.Controls 2.15

Dialog {
    anchors.centerIn: parent

    title: "About:"

    Label {
        text: "Creator: sweak\ngithub.com/sweakpl"
    }

    modal: true
    standardButtons: Dialog.Ok
}
