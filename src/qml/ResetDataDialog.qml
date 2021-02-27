import QtQuick.Controls 2.15

Dialog {
    anchors.centerIn: parent

    title: "Are You sure,\nYou want to clear\nall Your data?"

    modal: true

    standardButtons: Dialog.Ok | Dialog.Cancel

    onAccepted: {
        databaseHandler.resetDatabase()
        mainWindow.refreshAllViews()
    }
}
