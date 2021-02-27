import QtQuick 2.15
import QtQuick.Controls 2.15

Tumbler {
    model: 24

    currentIndex: new Date().getHours()
    visibleItemCount: 3

    delegate: TumblerDelegate {
        text: formatNumberIntoTwoDigits(modelData)

        font.pixelSize: tumblerFrame.height / 4.5
    }

    function formatNumberIntoTwoDigits(number) {
        return number < 10 && number >= 0 ? "0" + number : number.toString()
    }

    function setHour(hour) {
        currentIndex = hour
    }

    function reset() {
        currentIndex = new Date().getHours()
    }
}
