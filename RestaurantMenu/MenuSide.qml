import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Pane {
    id: root

    property alias sectionTitle: sectionLabel.text

    default property alias content: menuItemsColumn.data

    padding: 15
    background: Rectangle {
        color: "White"
        opacity: 0.75
        radius: 8
    }

    Layout.fillWidth: true

    ColumnLayout {
        id: menuItemsColumn
        anchors.fill: parent
        spacing: 12

        Label {
            id: sectionLabel
            text: qsTr("Sekcja")
            font.bold: true
            font.pixelSize: 24
            color: "black"
            Layout.bottomMargin: 5
        }

    }
}