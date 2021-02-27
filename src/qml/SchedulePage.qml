import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: schedulePage

    header: Label {
        text: "Schedule"

        font.pixelSize: mainWindow.height / 12
        padding: 20
    }

    AddEditActivityDialog {
        id: addEditActivityDialog
    }

    AddButton {
        id: addButton

        onClicked: openAddDialog()
    }

    ScheduleDaysSwipeView {
        id: scheduleDaysSwipeView
    }

    function openAddDialog() {
        addEditActivityDialog.editing = false
        addEditActivityDialog.open()
    }

    function openEditDialog() {
        addEditActivityDialog.editing = true
        addEditActivityDialog.setFieldsToCurrentItem()
        addEditActivityDialog.open()
    }

    function isDialogOpen() {
        return addEditActivityDialog.opened
    }

    function closeDialog() {
        addEditActivityDialog.close()
    }

    function refresh() {
        scheduleDaysSwipeView.refresh()
    }
}
