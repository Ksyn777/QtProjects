import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Page {
    id: menuControlPage
    background: null

    readonly property real totalCost: {
        var foodSum = (dish1.dishPrice * dish1.quantity) +
                      (dish2.dishPrice * dish2.quantity) +
                      (dish3.dishPrice * dish3.quantity) +
                      (mainDish1.dishPrice * mainDish1.quantity) +
                      (mainDish2.dishPrice * mainDish2.quantity) +
                      (mainDish3.dishPrice * mainDish3.quantity) +
                      (sideDish1.dishPrice * sideDish1.quantity) +
                      (sideDish2.dishPrice * sideDish2.quantity) +
                      (sideDish3.dishPrice * sideDish3.quantity) +
                      (breadDish1.dishPrice * breadDish1.quantity) +
                      (breadDish2.dishPrice * breadDish2.quantity) +
                      (breadDish3.dishPrice * breadDish3.quantity);

        return foodSum + Math.round(tipSlider.value);
    }

    header: Label {
        height: 70
        background: Rectangle { color: "White"; opacity: 0.6 }
        text: qsTr("Ahji - Bhaji")
        color: "Black"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 36
        font.bold: true
    }

    footer: Rectangle {
        height: 70
        color: "White"
        opacity: 0.7

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            Label {
                text: qsTr("Total Order Cost: $") + menuControlPage.totalCost
                font.pixelSize: 28
                font.bold: true
                color: "black"
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Order Now")
                font.pixelSize: 18
                icon.source: "images/light/checkout.svg"
                icon.color: "transparent"
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 15

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15

            MenuSide {
                sectionTitle: "Starters"
                MenuItemRow { id: dish1; dishName: "Onion Bhaji"; dishPrice: 10 }
                MenuItemRow { id: dish2; dishName: "Meat Samosa"; dishPrice: 12 }
                MenuItemRow { id: dish3; dishName: "Nargis Kebab"; dishPrice: 15 }
            }

            MenuSide {
                sectionTitle: "Mains"
                MenuItemRow { id: mainDish1; dishName: "Paneer Tikka"; dishPrice: 20 }
                MenuItemRow { id: mainDish2; dishName: "Lamb Bhuna"; dishPrice: 25 }
                MenuItemRow { id: mainDish3; dishName: "Murgh Tikka"; dishPrice: 28 }
            }

            Pane {
                Layout.fillWidth: true
                Layout.fillHeight: true
                background: Rectangle { color: "White"; opacity: 0.5; radius: 6 }
                padding: 10

                ColumnLayout {
                    anchors.fill: parent

                    Label {
                        text: "Spice Level"
                        font.pixelSize: 22
                        font.bold: true
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 15

                        Image { source: "images/light/mild.svg" }

                        Dial {
                            id: spiceDial
                            from: 0
                            to: 3
                            stepSize: 1
                            snapMode: Dial.SnapAlways
                            implicitWidth: 120
                            implicitHeight: 120
                        }

                        Image { source: "images/light/very_hot.svg" }
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15

            MenuSide {
                sectionTitle: "Sides"
                MenuItemRow { id: sideDish1; dishName: "Pilau Rice"; dishPrice: 10 }
                MenuItemRow { id: sideDish2; dishName: "Aloo Ghobi"; dishPrice: 12 }
                MenuItemRow { id: sideDish3; dishName: "Ahji Bahji"; dishPrice: 15 }
            }

            MenuSide {
                sectionTitle: "Breads"
                MenuItemRow { id: breadDish1; dishName: "Garlic Naan"; dishPrice: 15 }
                MenuItemRow { id: breadDish2; dishName: "Keema Naan"; dishPrice: 18 }
                MenuItemRow { id: breadDish3; dishName: "Naan at all"; dishPrice: 1 }
            }

            Pane {
                Layout.fillWidth: true
                Layout.fillHeight: true
                background: Rectangle { color: "White"; opacity: 0.5; radius: 6 }
                padding: 10

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 5

                    Label {
                        text: "Dining Options"
                        font.pixelSize: 22
                        font.bold: true
                    }

                    RowLayout {
                        spacing: 20
                        RadioButton { id: eatInRadio; text: "Eat In"; checked: true }
                        RadioButton { id: takeAwayRadio; text: "Take away" }
                    }

                    Label {
                        text: "Tip Amount"
                        font.pixelSize: 22
                        font.bold: true
                        Layout.topMargin: 5
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Slider {
                            id: tipSlider
                            from: 0
                            to: 50
                            value: 20
                            Layout.fillWidth: true
                        }
                        Label {
                            text: "$" + Math.round(tipSlider.value)
                            font.pixelSize: 24
                            font.bold: true
                        }
                    }
                }
            }
        }
    }
}