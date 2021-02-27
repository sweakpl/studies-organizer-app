import QtQuick 2.15
import QtQuick.Controls 2.15

SwipeView {
    z: 0
    anchors.fill: parent
    anchors.bottomMargin: addButton.height + addButton.anchors.bottomMargin + 10

    Page {
        property var dayName: "Monday"

        header: Label {
            text: parent.dayName

            font.pixelSize: mainWindow.height / 15
            padding: 20
        }
        MondayListView {
            id: mondayListView
        }
    }
    Page {
        property var dayName: "Tuesday"

        header: Label {
            text: parent.dayName

            font.pixelSize: mainWindow.height / 15
            padding: 20
        }
        TuesdayListView {
            id: tuesdayListView
        }
    }
    Page {
        property var dayName: "Wednesday"

        header: Label {
            text: parent.dayName

            font.pixelSize: mainWindow.height / 15
            padding: 20
        }
        WednesdayListView {
            id: wednesdayListView
        }
    }
    Page {
        property var dayName: "Thursday"

        header: Label {
            text: parent.dayName

            font.pixelSize: mainWindow.height / 15
            padding: 20
        }
        ThursdayListView {
            id: thursdayListView
        }
    }
    Page {
        property var dayName: "Friday"

        header: Label {
            text: parent.dayName

            font.pixelSize: mainWindow.height / 15
            padding: 20
        }
        FridayListView {
            id: fridayListView
        }
    }

    function currentScheduleDay() {
       return currentItem.dayName
    }

    function currentItemID() {
        switch(currentScheduleDay()) {
        case "Monday": return mondayListView.currentItemID()
        case "Wednesday": return wednesdayListView.currentItemID()
        case "Tuesday": return tuesdayListView.currentItemID()
        case "Thursday": return thursdayListView.currentItemID()
        case "Friday": return fridayListView.currentItemID()
        }
    }

    function currentItemActivityName() {
        switch(currentScheduleDay()) {
        case "Monday": return mondayListView.currentItemActivityName()
        case "Wednesday": return wednesdayListView.currentItemActivityName()
        case "Tuesday": return tuesdayListView.currentItemActivityName()
        case "Thursday": return thursdayListView.currentItemActivityName()
        case "Friday": return fridayListView.currentItemActivityName()
        }
    }

    function currentItemMinuteInt() {
        switch(currentScheduleDay()) {
        case "Monday": return mondayListView.currentItemMinuteInt()
        case "Wednesday": return wednesdayListView.currentItemMinuteInt()
        case "Tuesday": return tuesdayListView.currentItemMinuteInt()
        case "Thursday": return thursdayListView.currentItemMinuteInt()
        case "Friday": return fridayListView.currentItemMinuteInt()
        }
    }

    function currentItemHourInt() {
        switch(currentScheduleDay()) {
        case "Monday": return mondayListView.currentItemHourInt()
        case "Wednesday": return wednesdayListView.currentItemHourInt()
        case "Tuesday": return tuesdayListView.currentItemHourInt()
        case "Thursday": return thursdayListView.currentItemHourInt()
        case "Friday": return fridayListView.currentItemHourInt()
        }
    }

    function refresh() {
        mondayListView.refresh()
        wednesdayListView.refresh()
        tuesdayListView.refresh()
        thursdayListView.refresh()
        fridayListView.refresh()
    }
}
