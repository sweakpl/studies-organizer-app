import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Frame {
    id: tumblerFrame

    RowLayout {
        id: timeTumblerRowLayout

        HourTumbler {
            id: hourTumbler

            Layout.alignment: Qt.AlignHCenter
            Layout.maximumHeight: mainWindow.height / 10
        }

        Text {
            id: colon

            text: ":"

            color: darkMode ? "#dcdcdc" : "#000000"
            font.pixelSize: parent.height / 4
            font.bold: true

            Layout.alignment: Qt.AlignCenter
        }

        MinuteTumbler {
            id: minuteTumbler

            Layout.alignment: Qt.AlignHCenter
            Layout.maximumHeight: mainWindow.height / 10
        }
    }

    function getTime() {
        return formatNumberIntoTwoDigits(hourTumbler.currentIndex) + ":"
        + formatNumberIntoTwoDigits(minuteTumbler.currentIndex)
    }

    function setTime(minute, hour) {
        hourTumbler.setHour(hour)
        minuteTumbler.setMinute(minute)
    }

    function reset() {
        hourTumbler.reset()
        minuteTumbler.reset()
    }

    function formatNumberIntoTwoDigits(number) {
        return number < 10 && number >= 0 ? "0" + number : number.toString()
    }
}
