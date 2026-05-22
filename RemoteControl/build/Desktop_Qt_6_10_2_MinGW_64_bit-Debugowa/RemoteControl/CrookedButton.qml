// CrookedButton.qml
import QtQuick

Item {
    id: root

    property color buttonColor: "#696969"
    property real innerRadius: 40
    property real outerRadius: 100
    property real startAngle: 0
    property real angleSpan: 90

    // Udostępniamy MouseArea na zewnątrz dla efektów hover w Main.qml
    property alias mouseArea: clicker

    signal clicked()

    // Bezpieczny rozmiar roboczy dla Canvasu
    width: 250
    height: 250

    // Pomocnicza funkcja konwersji kątów
    function degreesToRadians(degrees) {
        return degrees * (Math.PI / 180);
    }
    MouseArea {
        id: clicker
        anchors.fill: parent
        hoverEnabled: true

        onPressed: (mouse) => {
            var centerX = width / 2;
            var centerY = height / 2;
            var dx = mouseX - centerX;
            var dy = mouseY - centerY;
            var distance = Math.sqrt(dx*dx + dy*dy);

            // Sprawdzanie promienia
            if (distance < root.innerRadius || distance > root.outerRadius) {
                mouse.accepted = false;
                return;
            }

            // Sprawdzanie kąta
            var angle = Math.atan2(dy, dx) * (180 / Math.PI);
            if (angle < 0) angle += 360;

            // Logika sprawdzania zakresu kątów
            var endAngle = root.startAngle + root.angleSpan;
            var inside = false;
            if (endAngle <= 360) {
                inside = (angle >= root.startAngle && angle <= endAngle);
            } else {
                inside = (angle >= root.startAngle || angle <= (endAngle - 360));
            }

            if (!inside) {
                mouse.accepted = false;
                return;
            }

            mouse.accepted = true;
            canvas.requestPaint();
        }

        onReleased: {
            if (containsMouse) root.clicked();
            canvas.requestPaint();
        }

        onContainsMouseChanged: canvas.requestPaint()
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        // Wymuszamy renderowanie do pamięci podręcznej, co poprawia obsługę cieni i przezroczystości
        renderTarget: Canvas.Image

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            var cx = width / 2;
            var cy = height / 2;

            var startRad = root.degreesToRadians(root.startAngle);
            var endRad = root.degreesToRadians(root.startAngle + root.angleSpan);

            // 1. USTAWIANIE MIĘKKIEGO CIENIA POD PRZYCISKIEM
            ctx.shadowColor = "rgba(0, 0, 0, 0.6)";
            ctx.shadowBlur = 10;
            ctx.shadowOffsetY = 4;

            // 2. BUDOWANIE ŚCIEŻKI WYCINKA KOŁA
            ctx.beginPath();
            ctx.arc(cx, cy, root.outerRadius, startRad, endRad, false);

            var innerEndX = cx + root.innerRadius * Math.cos(endRad);
            var innerEndY = cy + root.innerRadius * Math.sin(endRad);
            ctx.lineTo(innerEndX, innerEndY);

            ctx.arc(cx, cy, root.innerRadius, endRad, startRad, true);
            ctx.closePath();

            // 3. TWORZENIE WYRAŹNEGO GRADIENTU LINIOWEGO (GÓRA - DÓŁ DLA UPROSZCZENIA)
            // Używamy prostego gradientu pionowego, żeby wykluczyć błędy z pozycją skośną
            var grad = ctx.createLinearGradient(0, cy - root.outerRadius, 0, cy + root.outerRadius);

            if (clicker.pressed) {
                        // Stan wciśnięty: Ciemny
                        grad.addColorStop(0.0, Qt.darker(root.buttonColor, 1.6));
                        grad.addColorStop(0.5, Qt.darker(root.buttonColor, 1.3));
                        grad.addColorStop(1.0, root.buttonColor);
            } else if (clicker.containsMouse) {
                        var hoverColor = Qt.lighter(root.buttonColor, 1.15);
                        grad.addColorStop(0.0, Qt.lighter(hoverColor, 1.2));
                        grad.addColorStop(0.5, hoverColor);
                        grad.addColorStop(1.0, Qt.darker(hoverColor, 1.2));
            } else {
                // Stan normalny: Klasyczny, bezpieczny plastikowy gradient (Niezależny od root.buttonColor dla testu!)
                        grad.addColorStop(0.0, Qt.lighter(root.buttonColor, 1.3)); // Jasna góra (błysk)
                        grad.addColorStop(0.5, root.buttonColor);                  // Twój czysty kolor w środku
                        grad.addColorStop(1.0, Qt.darker(root.buttonColor, 1.4));   // Ciemny dół (cień)
            }

            ctx.fillStyle = grad;
            ctx.fill(); // Zamalowuje środek na sztywno podanymi wyżej kolorami hex

            // 4. WYŁĄCZAMY CIEŃ DLA CZYSTEGO KANTU
            ctx.shadowColor = "transparent";

            // Rysujemy jasną, białawą obwódkę wokół całego kształtu
            ctx.strokeStyle = clicker.pressed ? "#404040" : "#ffffff";
            ctx.lineWidth = 1.5;
            ctx.stroke();
        }
    }
}