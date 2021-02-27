import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Dialog {
    anchors.centerIn: parent

    title: editing ? "Edit the event" : "Add a new event"

    closePolicy: Popup.CloseOnEscape
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    property var editing: false

    ColumnLayout {
        TextField {
            id: eventTextField

            Layout.fillWidth: true

            placeholderText: "Event name"

            // Limit the text to 50 characters
            // and disable the Ok button if text is empty
            onTextChanged: {
                if (length > 50) remove(50, length)
                if (text != "") standardButton(Dialog.Ok).enabled = true
                else standardButton(Dialog.Ok).enabled = false
            }
        }

        DatePicker {
            id: datePicker

            Layout.fillWidth: true
        }

        TimeTumbler {
            id: timeTumbler

            Layout.fillWidth: true
        }

        Button {
            id: deleteButton

            text: "Delete Event"

            visible: editing
            Layout.fillWidth: true

            onClicked: {
                databaseHandler.deleteEvent(eventsListView.currentItemID())
                eventsListView.refresh()
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
            databaseHandler.addEvent(
                        eventTextField.text,
                        timeTumbler.getTime(),
                        datePicker.getDate())
        else
            databaseHandler.editEvent(
                        eventsListView.currentItemID(),
                        eventTextField.text,
                        timeTumbler.getTime(),
                        datePicker.getDate())

        eventsListView.refresh()
        resetDialog()
    }

    onRejected: {
        resetDialog()
    }

    function resetDialog() {
        eventTextField.clear()
        datePicker.reset()
        timeTumbler.reset()
        editing = false
    }

    function setFieldsToCurrentItem() {
        eventTextField.insert(0, eventsListView.currentItemEventName())
        datePicker.setDate(eventsListView.currentItemDayInt(),
                           eventsListView.currentItemMonthInt(),
                           eventsListView.currentItemYearInt())
        timeTumbler.setTime(eventsListView.currentItemMinuteInt(),
                            eventsListView.currentItemHourInt())
    }
}
