import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Page {
    id: menuPage

    visible: false

    header: Label {
        text: "Menu"

        font.pixelSize: mainWindow.height / 12
        padding: 20
    }

    Item {
        anchors.fill: parent
        anchors.margins: 30

        ColumnLayout {
            anchors.fill: parent

            ThemeToggleButton {
                Layout.topMargin: mainWindow.height / 20
                Layout.bottomMargin: mainWindow.height / 20
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            ResetDataButton {
                Layout.topMargin: mainWindow.height / 20
                Layout.bottomMargin: mainWindow.height / 20
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            AboutButton {
                Layout.topMargin: mainWindow.height / 20
                Layout.bottomMargin: mainWindow.height / 20
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    AboutDialog {
        id: aboutDialog
    }

    ResetDataDialog {
        id: resetDataDialog
    }

    function isDialogOpen() {
        if (aboutDialog.opened || resetDataDialog.opened)
            return true
    }

    function closeAllDialogs() {
        aboutDialog.close()
        resetDataDialog.close()
    }
}
