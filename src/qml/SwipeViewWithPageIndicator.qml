import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    SwipeView {
        id: swipeView

        anchors.fill: parent

        currentIndex: 1

        NotesPage {
            id: notesPage
        }

        SchedulePage {
            id: schedulePage
        }

        EventsPage {
            id: eventsPage
        }
    }

    PageIndicator {
        anchors.bottom: swipeView.bottom
        anchors.horizontalCenter: swipeView.horizontalCenter

        currentIndex: swipeView.currentIndex
        count: swipeView.count
    }

    function isDialogOpen() {
        return notesPage.isDialogOpen() ||
               schedulePage.isDialogOpen()||
               eventsPage.isDialogOpen()
    }

    function closeAllDialogs() {
        notesPage.closeDialog()
        schedulePage.closeDialog()
        eventsPage.closeDialog()
    }

    function refreshAllViews() {
        notesPage.refresh()
        schedulePage.refresh()
        eventsPage.refresh()
    }
}
