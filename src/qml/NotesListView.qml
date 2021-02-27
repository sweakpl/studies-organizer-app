import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import com.sweak.abstractsqlmodel 1.0

Item {
    id: notesListView

    anchors.fill: parent
    anchors.topMargin: 10
    anchors.bottomMargin: addButton.height + addButton.anchors.bottomMargin + 10
    anchors.leftMargin: 20
    anchors.rightMargin: 20

    property var itemWidth: mainWindow.width - anchors.leftMargin - anchors.rightMargin

    AbstractSqlModel {
        id: model

        query: "SELECT * FROM Notes ORDER BY ID ASC"
    }

    ListView {
        id: listView

        anchors.fill: parent

        model: model

        delegate: Item {
            width: itemWidth
            height: mainWindow.height / 30 + 10

            property var id: ID
            property var name: NoteName

            MouseArea {
                anchors.fill: parent

                onPressAndHold: {
                    listView.currentIndex = index
                    notesPage.openEditDialog()
                }
            }
            RowLayout {
                Label {
                    id: listBulletLabel

                    text: "• "

                    font.pixelSize: mainWindow.height / 35
                    font.bold: true
                }
                Text {
                    id: noteText

                    text: formatTextToFitTheScreen(NoteName)

                    color: darkMode ? "white" : "black"
                    font.pixelSize: mainWindow.height / 35
                }
            }
        }
    }

    function refresh() {
        model.refresh()
    }

    function formatTextToFitTheScreen(text) {
        // (mainWindow.height / 70) approximates "average" character width
        var maxLength = notesListView.itemWidth / (mainWindow.height / 70)

        if (text.includes("\n"))
            text = text.substring(0, text.indexOf("\n"))

        if (text.length >= maxLength)
            return text.substring(0, maxLength - 3) + "..."
        else return text
    }

    function currentItemID() {
        return listView.currentItem.id
    }

    function currentItemNoteName() {
        return listView.currentItem.name
    }
}
