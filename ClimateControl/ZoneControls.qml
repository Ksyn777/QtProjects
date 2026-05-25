import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts


Pane {
    id: root

    readonly property color temperatureColor: {
        if (celsius < 10)
            return Qt.color("lightblue")
        else if (celsius >= 10 && celsius < 20)
            return Qt.color("cyan")
        else if (celsius >= 20 && celsius < 30)
            return Qt.color("orange")
        else
            return Qt.color("red")
    }

    padding: 20
    background: Rectangle {
        color: "Black"
        opacity: 0.5
    }

    palette {
        windowText: root.temperatureColor
        dark: root.temperatureColor
    }

    property string zoneName
    property int celsius: temperatureDial.value
    property int fahrenheit: (celsius * 1.8) + 32

    RowLayout {
        anchors.fill: parent
        spacing: 10

        ColumnLayout {
            id: leftColumn
            spacing: 10

            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter

                CheckBox {
                    id: zoneEnabledCheckBox
                    checked: true
                    text: qsTr("Enable %1").arg(root.zoneName)
                }

                Switch {
                    id: unitsSwitch

                    text: qsTr("ºC / ºF")
                }
            }

            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter
                enabled: zoneEnabledCheckBox.checked
                Image {
                    source: Qt.resolvedUrl("assets/cool.svg")
                    Layout.alignment: Qt.AlignBottom
                }

                Dial {
                    id: temperatureDial
                    from: 0
                    to: 40
                    stepSize: 1
                    snapMode: Dial.SnapAlways
                    value: 21
                }

                Image {
                    source: Qt.resolvedUrl("assets/heat.svg")
                    Layout.alignment: Qt.AlignBottom
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }

            Rectangle {
                //color: "blue"

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        ColumnLayout {
            id: rightColumn
            spacing: 10
            Layout.fillWidth: true
            Layout.fillHeight: true

            enabled: zoneEnabledCheckBox.checked

            Label {
                text: unitsSwitch.checked ?
                        root.fahrenheit + "ºF" : root.celsius + "ºC"

                font {
                    weight: Font.ExtraLight
                    pixelSize: 200

                }

                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignRight

                renderType: Text.CurveRendering
            }

            RowLayout {
                spacing: 10
                Layout.fillWidth: true

                Image {
                    source: fanSpeedSlider.value > 0 ?
                                Qt.resolvedUrl("assets/fan_outline.svg") :
                                Qt.resolvedUrl("assets/fan_off.svg")

                    scale: 0.75
                    Layout.alignment: Qt.AlignVCenter
                }

                Slider {
                    id: fanSpeedSlider
                    from: 0
                    to: 100

                    Layout.fillWidth: true
                }

                Image {
                    source: Qt.resolvedUrl("assets/fan_fill.svg")
                    scale: 1.25
                    Layout.alignment: Qt.AlignVCenter
                }
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }



            Rectangle {
               // color: "blue"

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
