import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Dialog {
    anchors.centerIn: parent

    title: editing ? "Edit the activity" : "Add a new activity"

    closePolicy: Popup.CloseOnEscape
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    property var editing: false

    ColumnLayout {
        TextField {
            id: activityTextField

            Layout.fillWidth: true

            placeholderText: "Activity name"

            // Limit the text to 50 characters
            // and disable the Ok button if text is empty
            onTextChanged: {
                if (length > 50) remove(50, length)
                if (text != "") standardButton(Dialog.Ok).enabled = true
                else standardButton(Dialog.Ok).enabled = false
            }
        }

        TimeTumbler {
            id: timeTumbler

            Layout.fillWidth: true
        }

        Button {
            id: deleteButton

            visible: editing
            Layout.fillWidth: true

            text: "Delete Activity"

            onClicked: {
                databaseHandler.deleteActivity(
                            scheduleDaysSwipeView.currentScheduleDay(),
                            scheduleDaysSwipeView.currentItemID())
                scheduleDaysSwipeView.refresh()
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
            databaseHandler.addActivity(
                        scheduleDaysSwipeView.currentScheduleDay(),
                        activityTextField.text,
                        timeTumbler.getTime())
        else
            databaseHandler.editActivity(
                        scheduleDaysSwipeView.currentScheduleDay(),
                        scheduleDaysSwipeView.currentItemID(),
                        activityTextField.text,
                        timeTumbler.getTime())
        scheduleDaysSwipeView.refresh()
        resetDialog()
    }

    onRejected: {
        resetDialog()
    }

    function resetDialog() {
        activityTextField.clear()
        timeTumbler.reset()
    }

    function setFieldsToCurrentItem() {
        activityTextField.insert(0, scheduleDaysSwipeView.currentItemActivityName())
        timeTumbler.setTime(scheduleDaysSwipeView.currentItemMinuteInt(),
                            scheduleDaysSwipeView.currentItemHourInt())
    }
}
