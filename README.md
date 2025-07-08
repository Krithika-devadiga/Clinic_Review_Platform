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

- `main.dart` – App entry point  
- `LoginPage.dart` – Handles user login  
- `RegisterPage.dart` – User registration screen  
- `HomePage.dart` – Lists clinics from Firestore  
- `ClinicDetailsPage.dart` – Shows reviews for selected clinic  
- `AddReviewPage.dart` – Submit/edit clinic reviews  

---

## ⚙️ Getting Started

### 🔨 Prerequisites

- ✅ Flutter SDK installed
- ✅ Firebase project created
- ✅ Android/iOS emulator or physical device

---

## 🔑 Firebase Setup

1. Add Firebase to your Flutter project using the Firebase console.
2. Enable **Email/Password** authentication in Firebase Auth.
3. Create the following **Firestore Collections**:

### 🔥 Firestore Collections

#### `clinics`
- `name`: *String* → `"City Health Clinic"`
- `location`: *String* → `"Chennai"`
- `averageRating`: *Number* → `Optional`

#### `reviews`
- `clinicId`: *String* → Document ID of the clinic
- `userId`: *String* → UID of reviewer
- `rating`: *Number*
- `comment`: *String*
- `timestamp`: *Timestamp*

---

## ▶️ Run the App

```bash
git clone https://github.com/your-username/Clinic_Review_Platform.git
cd Clinic_Review_Platform
flutter pub get
flutter run
