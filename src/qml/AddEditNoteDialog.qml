import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Dialog {
    anchors.centerIn: parent

    title: editing ? "Edit the note" : "Add a new note"

    closePolicy: Popup.CloseOnEscape
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    property var editing: false

    ColumnLayout {
        anchors.fill: parent

        ScrollView {
            Layout.fillWidth: true

            TextArea {
                id: noteTextArea

                width: parent.width

                placeholderText: "Note"

                wrapMode: TextEdit.Wrap

                // Limit the text to 200 characters
                // and disable the Ok button if text is empty
                onTextChanged: {
                    if (length > 200) remove(200, length)
                    if (text != "") standardButton(Dialog.Ok).enabled = true
                    else standardButton(Dialog.Ok).enabled = false
                }
            }
        }

        Button {
            id: deleteButton

            text: "Delete Note"

            visible: editing
            Layout.fillWidth: true

            onClicked: {
                databaseHandler.deleteNote(notesListView.currentItemID())
                notesListView.refresh()
                resetDialog()
                close()
            }
        }
    }

    onOpened: {
        if (editing == false)
            standardButton(Dialog.Ok).enabled = false
    }

    onAccepted: {
        if (editing == false)
            databaseHandler.addNote(noteTextArea.text)
        else
            databaseHandler.editNote(
                        notesListView.currentItemID(),
                        noteTextArea.text)
        notesListView.refresh()
        resetDialog()
    }

    onRejected: {
        resetDialog()
    }

    function resetDialog() {
        noteTextArea.clear()
        editing = false
    }

    function setFieldsToCurrentItem() {
        noteTextArea.insert(0, notesListView.currentItemNoteName())
    }
}
