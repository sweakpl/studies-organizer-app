import QtQuick.Controls 2.15

Dialog {
    anchors.centerIn: parent

    title: "Press OK to quit"

    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    onAccepted: {
        applicationSettings.darkMode = mainWindow.darkMode
        Qt.quit()
    }
}
