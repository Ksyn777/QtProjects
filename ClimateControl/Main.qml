import QtQuick
import QtQuick.Controls.Basic


ApplicationWindow {
    width: 1024
    height: 800
    visible: true
    title: qsTr("Home Controls")

    
    Image {
        id: backgorundImage
        anchors.fill: parent
        source: "assets/BrushedMetal.jpg"
        fillMode: Image.PreserveAspectCrop
        
    }

    ClimateControl {
        anchors.fill: parent
    }

 
}
