import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

RowLayout {
    id: itemRoot
    spacing: 15
    Layout.fillWidth: true


    property string dishName: "Nazwa dania"
    property real dishPrice: 0.0

    property alias quantity: quantitySpinBox.value

    Label {
        text: itemRoot.dishName
        font.pixelSize: 18
        color: "black"
        Layout.fillWidth: true
    }

    Label {
        text: "$" + itemRoot.dishPrice.toFixed(0)
        font.bold: true
        color: "black"
    }

    SpinBox {
        id: quantitySpinBox
        from: 0
        to: 10
        value: 0
        stepSize: 1
        implicitWidth: 120
        implicitHeight: 40
    }
}