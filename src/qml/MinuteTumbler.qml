import QtQuick 2.15
import QtQuick.Controls 2.15

Tumbler {
    model: 60

    currentIndex: new Date().getMinutes()
    visibleItemCount: 3

    delegate: TumblerDelegate {
        text: formatNumberIntoTwoDigits(modelData)

        font.pixelSize: tumblerFrame.height / 4.5
    }

    function setMinute(minute) {
        currentIndex = minute
    }

    function reset() {
        currentIndex = new Date().getMinutes()
    }
}
