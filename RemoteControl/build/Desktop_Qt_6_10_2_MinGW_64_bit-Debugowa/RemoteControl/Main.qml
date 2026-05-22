import QtQuick

Window {
    width: 240
    height: 740
    visible: true

    RemoteBody {
        mainColor: "#222222"
    }

    component RemoteBody: Rectangle {
        id: body
        anchors.fill: parent
        radius: 40

        property color mainColor: "#2b2b2b"

        gradient: Gradient {
            GradientStop { position: 0.0; color: body.mainColor.lighter(1.2)}
            GradientStop {position: 0.5; color: body.mainColor }
            GradientStop {position: 1.0; color: body.mainColor.darker(1.5) }
        }

        Rectangle {
            id: innerBorder
            anchors.fill: parent
            anchors.margins: 6

            radius: body.radius - 6

            gradient: Gradient {
                GradientStop {position: 0.0; color: body.mainColor.darker(1.4)}
                GradientStop {position: 0.5; color: body.mainColor}
                GradientStop {position: 1.0; color: body.mainColor.lighter(1.1)}
            }

        }

    }

        TapHandler {
            id: clicker
        }

        Text {
            id: label
            anchors.centerIn: parent
            color: "white"
        }


    QtObject {
        id: tvControl

        property bool closedCaptionsEnabled: false
        property bool hdrEnabled: false
        property bool castConnected: false
        property bool muted: false
        property int channelNumber: 0
        property int volumeLevel: 0

        property var channelNames: [
            "NOTHING",
            "NEWS STATION",
            "COMEDY CABLE",
            "WEATHER CH",
            "CARTOONS",
            "SPORTS",
            "MTV",
            "HORROR MOVIE",
            "DRAMA",
            "ACTION"
        ]


        function nextChannel() {
            if (channelNumber < channelNames.length - 1) {
                channelNumber++
            } else {
                channelNumber = 0
            }
        }

        function prevChannel() {
            if (channelNumber > 0) {
                channelNumber--
            } else {
                channelNumber = channelNames.length - 1
            }
        }
    }

    Rectangle {
        width: parent.width - 20
        height: 100
        color: "#87a922"
        border.width: 1
        border.color: "White"
        anchors.verticalCenterOffset: -250
        anchors.centerIn: parent
        Column {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 5
            anchors.leftMargin: 10
            spacing: 5
            Text {
                text: "CHANNEL: " + tvControl.channelNumber
                color: "#1a2300"
                font.pixelSize: 20
                font.bold: true
            }

            Text {
                text: tvControl.channelNames[tvControl.channelNumber]
                color: "#1a2300"
                font.pixelSize: 18

            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                Repeater {
                    model: ["closed_caption_white.svg", "hdr_on_white.svg", "cast_white.svg", "speaker_muted_white.svg"]

                    Image {
                        width: 35
                        height: 30
                        source: "images/" + modelData
                        fillMode: Image.PreserveAspectFit

                        opacity: {
                            if (index === 0) return tvControl.closedCaptionsEnabled ? 1.0 : 0.05
                            if (index === 1) return tvControl.hdrEnabled ? 1.0 : 0.05
                            if (index === 2) return tvControl.castConnected ? 1.0 : 0.05
                            if (index === 3) return tvControl.muted ? 1.0 : 0.05
                            return 0.05
                        }
                    }
                }
            }
        }
        Rectangle {
            id: volumeFrame
            width: 10
            height: parent.height - 20
            color: "#5f7718"

            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                width: parent.width
                color: "#1a2300"
                anchors.bottom: parent.bottom

                height: parent.height * (tvControl.volumeLevel / 100)
            }
        }




    }

    Item {
        id: topButton
        width: 200
        height: 50
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -160
        //color: "Yellow"

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            Repeater {
                model: ["closed_caption_white.svg", "hdr_on_white.svg", "cast_white.svg", "speaker_muted_white.svg"]
                PilotButton {
                    width: topButton.width / 4
                    height: 35
                    radius: 10
                    Image {
                        width: parent.width - 5
                        height: 28
                        source: "images/" + modelData
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit
                    }
                    onClicked: {
                        if (index === 0) {
                            tvControl.closedCaptionsEnabled = !tvControl.closedCaptionsEnabled
                        } else if (index === 1) {
                            tvControl.hdrEnabled = !tvControl.hdrEnabled
                        } else if (index === 2) {
                            tvControl.castConnected = !tvControl.castConnected
                        } else if (index === 3) {
                            tvControl.muted = !tvControl.muted
                        }
                    }
                }

            }
        }

    }



    Item {
        width: 200
        height: 200
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -50

        PilotButton {
            id: speakerButton
            width: 80
            height: 80
            radius: width / 2
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height / 2 - height / 2
            Image {
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                source: "images/mic_white.svg"
            }

        }

        CrookedButton {
                id: prevButton
                anchors.centerIn: speakerButton

                // Konfiguracja kształtu z obrazka
                buttonColor: "#808080" // Szary
                innerRadius: 40
                outerRadius: 80
                startAngle: 135
                angleSpan: 90 // Wycinek 60 stopni

                Image {
                    // Obliczamy geometryczny środek komponentu
                    readonly property real centerX: prevButton.width / 2
                    readonly property real centerY: prevButton.height / 2

                    // Średni promień (dokładnie pomiędzy wewnętrznym a zewnętrznym)
                    readonly property real midRadius: (prevButton.innerRadius + prevButton.outerRadius) / 2

                    // Kąt środkowy wycinka przeliczony na radiany                        r
                    readonly property real midAngleRad: prevButton.degreesToRadians(prevButton.startAngle + (prevButton.angleSpan / 2))

                    // Ustawiamy szerokość i wysokość przed pozycjonowaniem
                    height: 30
                    width: 30

                    // Obliczamy pozycję X i Y (odejmując połowę wymiaru, aby wycentrować sam obrazek)
                    x: centerX + midRadius * Math.cos(midAngleRad) - (width / 2)
                    y: centerY + midRadius * Math.sin(midAngleRad) - (height / 2)

                    source: "images/fast_rewind.svg"
                }

                // Efekt hover: ramka wokół przycisku
                Canvas {
                    anchors.fill: parent
                    visible: prevButton.mouseArea.containsMouse // Tylko przy hover

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();
                        var cx = width / 2;
                        var cy = height / 2;
                        var startRad = prevButton.degreesToRadians(prevButton.startAngle);
                        var endRad = prevButton.degreesToRadians(prevButton.startAngle + prevButton.angleSpan);

                        ctx.beginPath();
                        ctx.arc(cx, cy, prevButton.outerRadius, startRad, endRad, false);
                        ctx.arc(cx, cy, prevButton.innerRadius, endRad, startRad, true);
                        ctx.closePath();

                        ctx.strokeStyle = "darkgrey";
                        ctx.lineWidth = 1;
                        ctx.stroke();
                    }
                }

                onClicked: console.log("Kliknięto przycisk WSTECZ!")
            }

        CrookedButton {
                id: settingButton
                anchors.centerIn: speakerButton

                // Konfiguracja kształtu z obrazka
                buttonColor: "#808080" // Szary
                innerRadius: 40
                outerRadius: 80
                startAngle: 225
                angleSpan: 90 // Wycinek 60 stopni

                Image {
                    // Obliczamy geometryczny środek komponentu
                    readonly property real centerX: settingButton.width / 2
                    readonly property real centerY: settingButton.height / 2

                    // Średni promień (dokładnie pomiędzy wewnętrznym a zewnętrznym)
                    readonly property real midRadius: (settingButton.innerRadius + settingButton.outerRadius) / 2

                    // Kąt środkowy wycinka przeliczony na radiany                        r
                    readonly property real midAngleRad: settingButton.degreesToRadians(settingButton.startAngle + (settingButton.angleSpan / 2))

                    // Ustawiamy szerokość i wysokość przed pozycjonowaniem
                    height: 30
                    width: 30

                    // Obliczamy pozycję X i Y (odejmując połowę wymiaru, aby wycentrować sam obrazek)
                    x: centerX + midRadius * Math.cos(midAngleRad) - (width / 2)
                    y: centerY + midRadius * Math.sin(midAngleRad) - (height / 2)

                    source: "images/settings.svg"
                }

                // Efekt hover: ramka wokół przycisku
                Canvas {
                    anchors.fill: parent
                    visible: settingButton.mouseArea.containsMouse // Tylko przy hover

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();
                        var cx = width / 2;
                        var cy = height / 2;
                        var startRad = settingButton.degreesToRadians(settingButton.startAngle);
                        var endRad = settingButton.degreesToRadians(settingButton.startAngle + settingButton.angleSpan);

                        ctx.beginPath();
                        ctx.arc(cx, cy, settingButton.outerRadius, startRad, endRad, false);
                        ctx.arc(cx, cy, settingButton.innerRadius, endRad, startRad, true);
                        ctx.closePath();

                        ctx.strokeStyle = "darkgrey";
                        ctx.lineWidth = 1;
                        ctx.stroke();
                    }
                }


                onClicked: console.log("Kliknięto przycisk USTAWIENIA!")
            }

        CrookedButton {
                id: futureButton
                anchors.centerIn: speakerButton

                // Konfiguracja kształtu z obrazka
                buttonColor: "#808080" // Szary
                innerRadius: 40
                outerRadius: 80
                startAngle: 315
                angleSpan: 90 // Wycinek 60 stopni

                Image {
                    // Obliczamy geometryczny środek komponentu
                    readonly property real centerX: futureButton.width / 2
                    readonly property real centerY: futureButton.height / 2

                    // Średni promień (dokładnie pomiędzy wewnętrznym a zewnętrznym)
                    readonly property real midRadius: (futureButton.innerRadius + futureButton.outerRadius) / 2

                    // Kąt środkowy wycinka przeliczony na radiany                        r
                    readonly property real midAngleRad: futureButton.degreesToRadians(futureButton.startAngle + (settingButton.angleSpan / 2))

                    // Ustawiamy szerokość i wysokość przed pozycjonowaniem
                    height: 30
                    width: 30

                    // Obliczamy pozycję X i Y (odejmując połowę wymiaru, aby wycentrować sam obrazek)
                    x: centerX + midRadius * Math.cos(midAngleRad) - (width / 2)
                    y: centerY + midRadius * Math.sin(midAngleRad) - (height / 2)

                    source: "images/fast_forward.svg"
                }

                // Efekt hover: ramka wokół przycisku
                Canvas {
                    anchors.fill: parent
                    visible: futureButton.mouseArea.containsMouse // Tylko przy hover

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();
                        var cx = width / 2;
                        var cy = height / 2;
                        var startRad = futureButton.degreesToRadians(futureButton.startAngle);
                        var endRad = futureButton.degreesToRadians(futureButton.startAngle + futureButton.angleSpan);

                        ctx.beginPath();
                        ctx.arc(cx, cy, futureButton.outerRadius, startRad, endRad, false);
                        ctx.arc(cx, cy, futureButton.innerRadius, endRad, startRad, true);
                        ctx.closePath();

                        ctx.strokeStyle = "darkgrey";
                        ctx.lineWidth = 1;
                        ctx.stroke();
                    }
                }

                onClicked: console.log("Kliknięto przycisk PRZEWIJANIA W PRÓD!")
            }

        CrookedButton {
                id: stopButton
                anchors.centerIn: speakerButton

                // Konfiguracja kształtu z obrazka
                buttonColor: "#808080" // Szary
                innerRadius: 40
                outerRadius: 80
                startAngle: 45
                angleSpan: 90 // Wycinek 60 stopni

                Image {
                    // Obliczamy geometryczny środek komponentu
                    readonly property real centerX: stopButton.width / 2
                    readonly property real centerY: stopButton.height / 2

                    // Średni promień (dokładnie pomiędzy wewnętrznym a zewnętrznym)
                    readonly property real midRadius: (stopButton.innerRadius + stopButton.outerRadius) / 2

                    // Kąt środkowy wycinka przeliczony na radiany                        r
                    readonly property real midAngleRad: stopButton.degreesToRadians(stopButton.startAngle + (stopButton.angleSpan / 2))

                    // Ustawiamy szerokość i wysokość przed pozycjonowaniem
                    height: 30
                    width: 30

                    // Obliczamy pozycję X i Y (odejmując połowę wymiaru, aby wycentrować sam obrazek)
                    x: centerX + midRadius * Math.cos(midAngleRad) - (width / 2)
                    y: centerY + midRadius * Math.sin(midAngleRad) - (height / 2)

                    source: "images/play_pause.svg"
                }

                // Efekt hover: ramka wokół przycisku
                Canvas {
                    anchors.fill: parent
                    visible: stopButton.mouseArea.containsMouse // Tylko przy hover

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();
                        var cx = width / 2;
                        var cy = height / 2;
                        var startRad = stopButton.degreesToRadians(stopButton.startAngle);
                        var endRad = stopButton.degreesToRadians(stopButton.startAngle + stopButton.angleSpan);

                        ctx.beginPath();
                        ctx.arc(cx, cy, stopButton.outerRadius, startRad, endRad, false);
                        ctx.arc(cx, cy, stopButton.innerRadius, endRad, startRad, true);
                        ctx.closePath();

                        ctx.strokeStyle = "darkgrey";
                        ctx.lineWidth = 1;
                        ctx.stroke();
                    }
                }

                onClicked: console.log("Kliknięto przycisk STOP!")
            }

    }

    Item {
        width: parent.width - 100
        height: parent.width - 10
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 160

        PilotButton {
            id: programButtonPlus
            width: 40
            height: parent.height / 4
            anchors.left: parent.left
            topLeftRadius: 20
            topRightRadius: 20
            Image {
                anchors.centerIn: parent
                height: 30
                width: 30
                source: "images/plus.svg"
            }
            onClicked: {

                if (tvControl.channelNumber < tvControl.channelNames.length - 1) {
                    tvControl.channelNumber++
                } else {
                    tvControl.channelNumber = 0
                }
            }
        }


        PilotButton {
            id: soundButtonPlus
            width: 40
            height: parent.height / 4
            anchors.right: parent.right
            topLeftRadius: 20
            topRightRadius: 20
            Image {
                anchors.centerIn: parent
                height: 30
                width: 30
                source: "images/volume_up.svg"
            }
            onClicked: {
                if (tvControl.volumeLevel < 100) {
                    tvControl.volumeLevel++
                }
            }
        }

    }
    Item {
        width: parent.width - 100
        height: parent.width - 10
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 220

        PilotButton {
            id: programButtonMinus
            width: 40
            height: parent.height / 4
            anchors.left: parent.left
            bottomLeftRadius: 20
            bottomRightRadius: 20
            Image {
                anchors.centerIn: parent
                height: 30
                width: 30
                source: "images/minus.svg"
            }
            onClicked: {
                if (tvControl.channelNumber > 0) {
                    tvControl.channelNumber--
                } else {

                    tvControl.channelNumber = tvControl.channelNames.length - 1
                }
            }
        }
        PilotButton {
            id: soundButton
            width: 40
            height: parent.height / 4
            anchors.right: parent.right
            bottomLeftRadius: 20
            bottomRightRadius: 20
            Image {
                anchors.centerIn: parent
                height: 30
                width: 30
                source: "images/volume_down.svg"
            }
            onClicked: {
                if (tvControl.volumeLevel > 0) {
                    tvControl.volumeLevel--
                }
            }
        }

    }

    Item {
        id: numberButtons
        width: 200
        height: 160
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        anchors.bottomMargin: 40
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            Grid {
                columns: 3
                spacing : 10

                Repeater {
                    id: pilotRepeter
                    model: 9
                    PilotButton {
                        height: 40
                        width: 40
                        radius: 10
                        Text{
                            text: index + 1
                            anchors.centerIn: parent
                        }
                        onClicked: tvControl.channelNumber = index + 1
                    }
                }

            }
            spacing: 10
            PilotButton {
                id: zeroButton
                height: 30
                width: 140
                radius: 10
                Text{
                    text: "0"
                    anchors.centerIn: parent

                }
                onClicked: tvControl.channelNumber = 0
            }

        }
    }

}








