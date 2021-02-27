import QtQuick.Controls 2.15

ComboBox {
    model: getYearList(beginningYear, endingYear)
    currentIndex: convertYearToIndex(new Date().getFullYear())

    property var beginningYear: 2021
    property var endingYear: 2050

    function getYearList(start, end) {
        var yearList = []
        while (end >= start)
            yearList.push(end--)
        yearList.reverse()
        return yearList
    }

    function convertYearToIndex(year) {
        var yearCount = endingYear - beginningYear
        var difference = endingYear - year
        return yearCount - difference
    }

    function getCurrentYear() {
        return currentValue
    }

    function setYear(year) {
        currentIndex = convertYearToIndex(year)
    }

    function reset() {
        currentIndex = convertYearToIndex(new Date().getFullYear())
    }
}
