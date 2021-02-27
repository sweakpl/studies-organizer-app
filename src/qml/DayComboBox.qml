import QtQuick.Controls 2.15

ComboBox {
    model: getDaysList()

    currentIndex: new Date().getDate() - 1

    function getDaysList() {
        var daysList = []
        var end = monthComboBox.getDaysInMonth()
        while (end)
            daysList.push(end--)
        daysList.reverse()
        return daysList
    }

    function setDay(day) {
        currentIndex = day - 1
    }

    function reset() {
        currentIndex = new Date().getDate() - 1
    }
}
