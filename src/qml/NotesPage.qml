import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: notesPage

    z: 2

    header: Label {
        text: "Notes"

        font.pixelSize: mainWindow.height / 12
        padding: 20
    }

    AddEditNoteDialog {
        id: addEditNoteDialog
    }

    NotesListView {
        id: notesListView
    }

    AddButton {
        id: addButton

        onClicked: openAddDialog()
    }

    function openAddDialog() {
        addEditNoteDialog.editing = false
        addEditNoteDialog.open()
    }

    function openEditDialog() {
        addEditNoteDialog.editing = true
        addEditNoteDialog.setFieldsToCurrentItem()
        addEditNoteDialog.open()
    }

    function isDialogOpen() {
        return addEditNoteDialog.opened
    }

    function closeDialog() {
        addEditNoteDialog.close()
    }

    function refresh() {
        notesListView.refresh()
    }
}
