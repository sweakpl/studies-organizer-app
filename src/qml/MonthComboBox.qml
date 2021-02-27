import QtQuick.Controls 2.15

ComboBox {
    model: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    currentIndex: new Date().getMonth()

    function getDaysInMonth() {
        var curInd = currentIndex
        if (curInd === 1) {
            if (yearComboBox.getCurrentYear() % 4 === 0)
                return 29
            else
                return 28
        }
        else if (curInd === 0 || curInd === 2 || curInd === 4 ||
                 curInd === 6 || curInd === 7 || curInd === 9 || curInd === 11)
            return 31
        else
            return 30
    }

    function setMonth(month) {
        currentIndex = month - 1
    }

    function reset() {
        currentIndex = new Date().getMonth()
    }
}
