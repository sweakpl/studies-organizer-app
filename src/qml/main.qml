import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Universal 2.15
import Qt.labs.settings 1.1
import com.sweak.databasehandler 1.0

ApplicationWindow {
    id: mainWindow

    visible: true
    Universal.theme: darkMode ? Universal.Dark : Universal.Light

    property var darkMode: applicationSettings.darkMode

    DatabaseHandler {
        id: databaseHandler
    }

    Settings {
        id: applicationSettings

        property var darkMode: false
    }

    StackView {
        id: pageStack

        anchors.fill: parent

        initialItem: swipeViewWithPageIndicator
    }

    SwipeViewWithPageIndicator {
        id: swipeViewWithPageIndicator
    }

    MenuPage {
        id: menuPage
    }

    MenuButton {
        id: menuButton
    }

    QuitDialog {
        id: quitDialog
    }

    // Handling the "back button" on a phone
    onClosing: {
        close.accepted = false
        if (menuPage.visible) {
            if (menuPage.isDialogOpen())
                menuPage.closeAllDialogs()
            else
                pageStack.pop()
        }
        else if (quitDialog.opened)
            quitDialog.close()
        else if (swipeViewWithPageIndicator.isDialogOpen())
            swipeViewWithPageIndicator.closeAllDialogs()
        else
            quitDialog.open()
    }

    function refreshAllViews() {
        swipeViewWithPageIndicator.refreshAllViews()
    }
}
