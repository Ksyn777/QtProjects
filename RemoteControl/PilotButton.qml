import QtQuick

Rectangle {
    id: pilotButton
    width: 80
    height: 38
    border.width: 1
    border.color: Qt.lighter("#808080")

    property color button: "gray"
    signal clicked()

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: clicker.pressed ? pilotButton.button.darker(1.3) : pilotButton.button.lighter(1.1)
        }
        GradientStop {
            position: 1.0
            color: clicker.pressed ? pilotButton.button.lighter(1.1) : pilotButton.button.darker(1.3)
        }
    }


    TapHandler {
        id: clicker
        onTapped: pilotButton.clicked()
    }

}