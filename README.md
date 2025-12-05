# FitHer – Women's Fitness App 👟💪

A comprehensive mobile fitness application built with **Flutter**, designed specifically for women to manage their fitness journey. FitHer empowers users to explore personalized workout plans, track their sessions, and monitor progress over time.

> **⚠️ Important:** This app requires a backend server to function. Make sure the backend is running before testing.  
> Backend repository: [FitHer Backend (Laravel)](https://github.com/flowSar/fitness_app_backend_laravel)

---

## ✨ Features

- 🏋️‍♀️ **Workout Plans** – Browse and follow curated workout routines
- 📅 **Session Tracking** – Log and track your workout sessions
- 🔐 **Authentication** – Secure user registration and login
- 📊 **Progress Monitoring** – Visualize your fitness journey
- 🌸 **Intuitive UI** – Clean, user-friendly design tailored for women
- 🧱 **Robust Architecture** – Built using Clean Architecture + BLoC pattern

---

## 🛠️ Tech Stack

| Layer             | Technology                                |
|-------------------|-------------------------------------------|
| **Frontend**      | Flutter (Dart)                            |
| **Architecture**  | Clean Architecture                        |
| **State Management** | BLoC (Business Logic Component)        |
| **Backend**       | REST API (Laravel - separate repo)       |
| **Database**      | MySQL (backend-managed)                   |

---

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.0 or higher)
- [Dart](https://dart.dev/get-dart)
- Android Studio / Xcode (for emulators)
- A physical device or emulator for testing

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/flowSar/fitness_app_flutter.git
cd fitness_app_flutter
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Configure Backend API

Open the API configuration file:

```bash
lib/core/constants/constants.dart
```

Update the `serverApiUrl` with your backend server URL:

```dart
const String serverApiUrl = "http://YOUR_BACKEND_IP:8000/api";
```

**Examples:**
- Local development: `http://127.0.0.1:8000/api`
- Physical device testing: `http://192.168.x.x:8000/api` (use your computer's IP)
- Production: `https://your-domain.com/api`

### 4️⃣ Run the Application

Connect your device or start an emulator, then execute:

```bash
flutter run
```

For specific platforms:
```bash
flutter run -d android    # Run on Android
```

---

## 🧪 Testing the App

1. **Launch the app** on your device/emulator
2. **Register** a new account with valid credentials
3. **Log in** to access the main features
4. **Explore** workout plans and start tracking sessions


---

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point
├── b_navigation_bar.dart          # Bottom navigation
├── welcome_screen.dart            # Welcome/onboarding
├── models/                        # Global data models
├── components/                    # Reusable UI components
├── core/                          # Core utilities
│   ├── constants/                 # App-wide constants
│   ├── router/                    # Navigation routing
│   ├── services/                  # API services
│   ├── shared_preferences/        # Local storage
│   └── utils/                     # Helper functions
├── dependencies_injection.dart    # DI setup
└── features/                      # Feature modules
    ├── auth/                      # Authentication
    │   ├── data/                  # Data sources & repositories
    │   ├── domain/                # Business logic & entities
    │   └── presentation/          # UI & BLoC
    ├── explore/                   # Workout exploration
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── nutrition/                 # Nutrition tracking
    │   └── presentation/
    ├── settings/                  # User settings
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    └── workout/                   # Workout management
        ├── data/
        ├── domain/
        └── presentation/
```

### Architecture Layers

- **Domain**: Business logic, entities, and use cases
- **Data**: Repository implementations and API integration
- **Presentation**: UI components with BLoC state management

---

## 🔧 Configuration

### Environment Variables

You may need to configure additional settings based on your environment:

- API endpoints in `lib/core/constants/constants.dart`
- App-wide constants in `lib/core/constants/`
- Asset paths and theme configuration

---

## 🎯 Roadmap & Future Enhancements

- [ ] 🎥 Exercise animations and video tutorials
- [ ] 🔔 Push notifications and workout reminders
- [ ] 🥗 Comprehensive nutrition and meal tracking
- [ ] ☁️ Cloud-based profile synchronization
- [ ] 👥 Social features and community progress sharing
- [ ] 📈 Advanced analytics and insights
- [ ] 🌐 Multi-language support


---

## 👤 Author

**flowSar**

- GitHub: [@flowSar](https://github.com/flowSar)
- Frontend: [FitHer Flutter App](https://github.com/flowSar/fitness_app_flutter)
- Backend: [FitHer Laravel API](https://github.com/flowSar/fitness_app_backend_laravel)
