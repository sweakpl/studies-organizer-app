import QtQuick 2.15
import QtQuick.Controls 2.15

Text {
    text: modelData

    color: darkMode ? "#dcdcdc" : "#000000"

    opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}
