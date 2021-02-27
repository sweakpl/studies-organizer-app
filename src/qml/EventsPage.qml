import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: eventsPage

    z: 2

    header: Label {
        text: "Events"

        font.pixelSize: mainWindow.height / 12
        padding: 20
    }

    AddEditEventDialog {
        id: addEditEventDialog
    }

    EventsListView {
        id: eventsListView
    }

    AddButton {
        id: addButton

        onClicked: openAddDialog()
    }

    function openAddDialog() {
        addEditEventDialog.editing = false
        addEditEventDialog.open()
    }

    function openEditDialog() {
        addEditEventDialog.editing = true
        addEditEventDialog.setFieldsToCurrentItem()
        addEditEventDialog.open()
    }

    function isDialogOpen() {
        return addEditEventDialog.opened
    }

    function closeDialog() {
        addEditEventDialog.close()
    }

    function refresh() {
        eventsListView.refresh()
    }
}
