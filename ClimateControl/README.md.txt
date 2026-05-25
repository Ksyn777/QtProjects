# 🎛️ Responsive Climate Control UI (Qt/QML)

A modern, highly responsive, and modular user interface for a Climate Control System, designed for Automotive Infotainment (IVI) or Smart Home dashboards. Built entirely using **Qt 6**, **QML (Qt Quick Controls)**, and **JavaScript**.

## 🚀 Key Features
* **Modular Architecture:** Fully decoupled, reusable components (`ZoneControls`, `CrookedButton`) adhering to QML best practices.
* **Dual-Zone Control:** Independent settings for multiple zones (e.g., driver and passenger) powered by dynamic object instancing.
* **Custom 3D Vector Graphics:** Custom curved buttons and radial dials rendered on the fly via `Canvas 2D` API with real-time drop shadows, gradients, and bevel effects.
* **Fluid Responsiveness:** Utilizes `Layouts` (Column/Row) for flawless scaling across multiple screen resolutions (tested on 1024x800).
* **Dynamic Styling:** Text colors and UI accents automatically shift depending on the current temperature (Cold = Cyan/Blue, Hot = Orange/Red).

## 🛠️ Tech Stack
* **Framework:** Qt 6 (Qt Quick / Qt Quick Controls)
* **Languages:** QML, JavaScript
* **Features Used:** Canvas 2D, Property Binding, Property Aliases, Anchor Layouts

![App Screenshot](ControlScreen.png)