import QtQuick
import QtQuick.Controls.Basic

ApplicationWindow {
    width: 800
    height: 800
    visible: true
    title: qsTr("Ahji - Bhaji Restaurant Menu")

    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "images/curry.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    MenuControl {
        anchors.fill: parent
        anchors.margins: 10
    }
}