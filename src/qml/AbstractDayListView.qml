import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Item {
    id: rootItem

    anchors.fill: parent
    anchors.topMargin: 10
    anchors.leftMargin: 20
    anchors.rightMargin: 20

    property var itemWidth: mainWindow.width - anchors.leftMargin - anchors.rightMargin
    property var timeWidth: mainWindow.height * 0.06
    property var model

    ListView {
        id: listView

        anchors.fill: parent

        model: rootItem.model

        delegate: Item {
            width: itemWidth
            height: mainWindow.height / 30 + 10

            property var id: ID
            property var name: ActivityName
            property var time: ActivityTime

            MouseArea {
                anchors.fill: parent

                onPressAndHold: {
                    listView.currentIndex = index
                    schedulePage.openEditDialog()
                }
            }
            RowLayout {
                Text {
                    id: timeText
                    text: ActivityTime
                    color: darkMode ? "white" : "black"

                    font.pixelSize: mainWindow.height / 40
                    font.bold: true
                }
                Text {
                    id: activityText

                    text: formatTextToFitScreen(ActivityName)
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
        var availableSpace = rootItem.itemWidth - rootItem.timeWidth
        // (mainWindow.height / 70) approximates "average" character width
        var maxLength = availableSpace / (mainWindow.height / 70)

        if (text.length >= maxLength)
            return text.substring(0, maxLength - 3) + "..."
        else return text
    }

    function currentItemID() {
        return listView.currentItem.id
    }

    function currentItemActivityName() {
        return listView.currentItem.name
    }

    function currentItemMinuteInt() {
        return Number(listView.currentItem.time.substring(3, 5))
    }

    function currentItemHourInt() {
        return Number(listView.currentItem.time.substring(0, 2))
    }
}
