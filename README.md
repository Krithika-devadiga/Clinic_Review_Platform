# 🏥 Clinic Review App

A Flutter app that allows users to register, login, view clinics, add/edit reviews, and see ratings. Built using Firebase Authentication and Firestore.

---

## 🚀 Features

- 🔐 User Registration & Login (Firebase Auth)
- 🏥 List of Clinics from Firestore
- ✍️ Add/Edit/Delete Reviews
- ⭐ Display average ratings
- 📊 Star rating display
- 🎯 Responsive UI with modern design
- 📷 Splash screen (optional)

---

## 📂 Folder Structure












---

## ⚙️ Getting Started

🔨 Prerequisites
✅ Flutter SDK installed

✅ Firebase project created

✅ Android/iOS emulator or physical device


🔑 Firebase Setup :

- Make sure to initialize Firebase in main.dart with correct config.

- Create a Firestore collection: clinics

- Fields: name (String), location (String), averageRating (Number, optional)

- Create a reviews collection to store user reviews.

💡 Firebase Auth
Enable Email/Password login method in Firebase Console.

🚀 Run the app

1. Clone the repo:
```bash
git clone https://github.com/your-username/Clinic_Review_Platform.git
cd Clinic_Review_Platform
flutter pub get
flutter run
