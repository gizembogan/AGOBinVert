# 📱 AGO BinVert – Smart Waste Monitoring App

This Flutter application is part of the **AGO BinVert smart waste monitoring system**. It connects with smart trash bins via **Bluetooth** and displays their real-time fill levels using a clean, interactive interface.

The app is designed to help municipalities or facility managers monitor bin usage efficiently and get notified when bins are nearly full.

This application was developed as part of a university group project for the course **CENG 424 – Embedded Computer Systems (Spring 2025)**.

The full project includes both hardware (smart bin with dual ultrasonic sensors) and this mobile app.

---

## 🚀 What the App Does

- 🔄 **Receives real-time data** from Arduino-based sensors via Bluetooth
- 📍 **Displays bin locations** on a Google Map
- 📊 **Shows fill levels** of each bin using dynamic icons and colors
- 🔔 **Sends notifications** when bins reach threshold capacity
- 🔗 Automatically **reconnects to Bluetooth** if the connection drops
- ☁️ **Syncs with Firebase Realtime Database** to store and retrieve bin data

---

## 🧪 Technologies Used

- **Flutter** – cross-platform mobile app development
- **Dart** – primary programming language
- **Firebase** – for data storage and push notifications
- **flutter_bluetooth_serial_ble** – Bluetooth communication
- **Google Maps Flutter plugin** – to show bin locations

---

## 🧱 How It Works

1. The app connects with nearby smart bins using Bluetooth.
2. Each bin contains two ultrasonic sensors measuring trash level.
3. The app receives these measurements and visualizes them on a map.
4. When a bin reaches a certain threshold, the app shows a warning and sends a notification.
5. All data is synchronized with Firebase for backup and remote access.

---

## 🛠️ Setup Instructions

- Connect a bin trough Bluetooth.
- Ensure `google-services.json` is added to the project (`android/app/`).
- Create a `.env` file with your Firebase API key:

```env
FIREBASE_API_KEY=your_firebase_api_key_here
