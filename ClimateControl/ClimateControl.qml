import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Page {
    padding: 10

    background: null

    header: Label {
        text: qsTr("Climate Control")
        color: "white"
        font.pixelSize: 48
        padding: 10
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        ZoneControls {
            id: zone1

            zoneName: qsTr("zone1")
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ZoneControls {
            id: zone2

            zoneName: qsTr("zone2")
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }


}
