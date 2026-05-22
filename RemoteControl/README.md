# Interactive Smart TV Remote Control (Qt Quick / QML)

Fully interactive, modern Smart TV remote control application built from scratch using **Qt 6 (Qt Quick)** and **QML** with logic handled in **JavaScript**. 

The project focuses on advanced state management, component-driven architecture, and custom geometric UI elements.

## 🚀 Key Features Implemented

* **Dynamic Retro LCD Display:** Features a custom pixel-style screen (`#87a922`) that displays real-time data bound directly to the application state (active channel name and volume level).
* **State-Driven SVG Indicators:** Status icons (CC, HDR, Cast, Mute) built with a custom `Repeater` that dynamically adjust their opacity/visibility using a "ghost LCD pixel" effect depending on the active features.
* **Core State Management:** Built a central "brain" using a `QtObject` that controls the TV's behavior, allowing synchronized data-binding between the buttons and the display.
* **Smart Navigation Logic:** Implemented JavaScript functions for safe-boundary volume adjustment (0–100) and cyclical channel switching that automatically wraps around the channel list.
* **Custom Geometric D-Pad:** Multi-segmented navigation wheel using `Canvas` and advanced trigonometric math (`Math.cos`, `Math.sin`) to perfectly center and space custom-shaped action buttons.
* **Responsive Layouts:** Grid-based numpad layout (`Grid` + `Repeater`) and perfectly unified button capsules for volume and program switching using structural positioning.

## 🛠️ Technologies Used

* **Language:** QML, JavaScript (ES6+)
* **Framework:** Qt 6 / Qt Quick
* **Graphics:** Scalable Vector Graphics (SVG), Qt Quick Canvas 2D

## 📸 Preview
*(Tip: Replace this placeholder with a real screenshot of your remote!)*
![Smart TV Remote Preview](images/RemoteControl.png)
