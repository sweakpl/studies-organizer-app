import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import com.sweak.abstractsqlmodel 1.0

Item {
    id: eventsListView

    anchors.fill: parent
    anchors.topMargin: 10
    anchors.bottomMargin: addButton.height + addButton.anchors.bottomMargin + 10
    anchors.leftMargin: 20
    anchors.rightMargin: 20

    property var itemWidth: mainWindow.width - anchors.leftMargin - anchors.rightMargin
    property var timeWidth: mainWindow.height * 0.23

    AbstractSqlModel {
        id: model

        query: "SELECT * FROM Events ORDER BY SecsSinceEpoch ASC"
    }

    ListView {
        id: listView

        anchors.fill: parent

        model: model

        delegate: Item {
            width: itemWidth
            height: mainWindow.height / 30 + 10

            property var id: ID
            property var name: EventName
            property var date: EventDate.length === 10 ? "0" + EventDate : EventDate
            property var time: EventTime

            MouseArea {
                anchors.fill: parent

                onPressAndHold: {
                    listView.currentIndex = index
                    eventsPage.openEditDialog()
                }
            }
            RowLayout {
                Text {
                    id: dateText

                    text: EventDate

                    color: darkMode ? "white" : "black"
                    font.pixelSize: mainWindow.height / 40
                    font.bold: true
                }
                Text {
                    id: timeText
                    text: EventTime

                    color: darkMode ? "white" : "black"
                    font.pixelSize: mainWindow.height / 40
                    font.bold: true
                }
                Text {
                    id: eventText

                    text: formatTextToFitScreen(EventName)

                    color: darkMode ? "white" : "black"
                    font.pixelSize: mainWindow.height / 35
                }
            }
        }
    }

    function refresh() {
        model.refresh()
    }

    function formatTextToFitScreen(text) {
        var availableSpace = eventsListView.itemWidth - eventsListView.timeWidth
        // (mainWindow.height / 70) approximates "average" character width
        var maxLength = availableSpace / (mainWindow.height / 70)

        if (text.length >= maxLength)
            return text.substring(0, maxLength - 3) + "..."
        else return text
    }

    function currentItemID() {
        return listView.currentItem.id
    }

    function currentItemEventName() {
        return listView.currentItem.name
    }

    function currentItemDayInt() {
        return Number(listView.currentItem.date.substring(0, 2))
    }

    function currentItemMonthInt() {
        var monthName = listView.currentItem.date.substring(3, 6)
        var monthNamesList = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        return monthNamesList.indexOf(monthName) + 1
    }

    function currentItemYearInt() {
        return Number(listView.currentItem.date.substring(7, 11))
    }

    function currentItemMinuteInt() {
        return Number(listView.currentItem.time.substring(3, 5))
    }

    function currentItemHourInt() {
        return Number(listView.currentItem.time.substring(0, 2))
    }
}
