import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Frame {
    id: pickerFrame

    ColumnLayout {
        id: datePickerColumnLayout

        YearComboBox {
            id: yearComboBox

            Layout.fillWidth: true
        }

        MonthComboBox {
            id: monthComboBox

            Layout.fillWidth: true
        }

        DayComboBox {
            id: dayComboBox

            Layout.fillWidth: true
        }
    }

    function getDate() {
        return dayComboBox.currentText + " "
            + monthComboBox.currentText + " "
            + yearComboBox.currentText
    }

    function setDate(day, month, year) {
        yearComboBox.setYear(year)
        monthComboBox.setMonth(month)
        dayComboBox.setDay(day)
    }

    function reset() {
        yearComboBox.reset()
        monthComboBox.reset()
        dayComboBox.reset()
    }
}
