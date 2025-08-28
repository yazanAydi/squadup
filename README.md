# SquadUp - Connect • Play • Win

A modern Flutter app for connecting sports players and organizing games, built with Clean Architecture and following SquadUp branding guidelines.

## 🎨 Branding & Design

### Colors
- **Primary**: #8B5CF6 (Purple)
- **Primary Light**: #A78BFA (Lighter Purple)
- **Background**: #0F0A1F (Dark)
- **Surface**: #1C1532 (Card Background)
- **Text Primary**: #FFFFFF (White)
- **Text Secondary**: #A1A1AA (Secondary Text)
- **Accent Glow**: #7C3AED (Glow Effect)

### Logo
- **Primary Logo**: Gradient "SJ" text in purple range (#8B5CF6 → #A78BFA)
- **App Icon**: Dark rounded square with centered "SJ" gradient mark
- **Safe Area**: Padding ≥ ½ logo height around placements

## 🏗️ Architecture

### Clean Architecture Structure
```
lib/
├── core/           # Core functionality
│   ├── theme/     # App theming and colors
│   ├── di/        # Dependency injection
│   ├── errors/    # Error handling
│   └── logging/   # Logging system
├── screens/        # UI screens
├── widgets/        # Reusable widgets
├── providers/      # State management (Riverpod)
├── services/       # Business logic
├── models/         # Data models
└── l10n/          # Localization
```

### State Management
- **Riverpod** for state management
- **Clean separation** between presentation, domain, and data layers
- **Repository pattern** for data access

## 🚀 Features

### Core Features
- ✅ **Splash Screen** with SquadUp branding and 2-second fade
- ✅ **Authentication** with email/password
- ✅ **Language Selection** (English/Arabic) with RTL support
- ✅ **Modern UI** with SquadUp theme and colors
- ✅ **Responsive Design** with proper safe areas
- ✅ **Firebase Integration** ready

### UI Components
- **SquadUp Logo Widget** with gradient "SJ" and glow effects
- **Custom Theme** with SquadUp brand colors
- **Modern Cards** with rounded corners (16px radius)
- **Enhanced Buttons** with proper styling
- **Input Fields** with SquadUp branding

## 📱 Screens

### 1. Splash Screen
- Solid #0F0A1F background
- Centered SquadUp logo with soft glow
- 2-second fade to Sign In
- Loading indicator

### 2. Auth Screen
- Language selector (EN/العربية)
- SquadUp logo and branding
- Sign In/Sign Up toggle
- Form validation
- Navigation to Home Screen

### 3. Home Screen
- AppBar with SquadUp icon-only logo
- Welcome message
- Feature cards grid
- Create Game FAB

## 🌍 Localization

### Supported Languages
- **English (EN)** - LTR layout
- **Arabic (العربية)** - RTL layout

### Features
- **Dynamic language switching** in auth screen
- **RTL support** for Arabic
- **Localized text** for all UI elements
- **Proper text direction** handling

## 🔧 Setup & Installation

### Prerequisites
- Flutter SDK 3.8.1+
- Dart SDK
- Android Studio / VS Code
- Firebase project (for full functionality)

### Installation
1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

### Asset Requirements
Replace placeholder files with actual images:
- `assets/images/logoo.png` - SquadUp logo image (main logo)

## 🎯 Development Guidelines

### Code Style
- Run `dart format` on save
- `flutter analyze` must pass with no warnings
- Follow Clean Architecture principles
- Use Riverpod for state management

### Testing
- **Unit tests** for repositories and models
- **Widget tests** for screens
- **Golden tests** for UI consistency
- **70% coverage** minimum requirement

### Firebase Setup
- Enable Firestore offline persistence
- Configure security rules
- Set up authentication methods
- Enable analytics and crash reporting

## 📋 TODO

### Immediate
- [ ] Implement actual Firebase authentication
- [ ] Add proper error handling
- [ ] Create user profile management
- [ ] Implement game creation/joining

### Future
- [ ] Team management features
- [ ] Real-time game updates
- [ ] Push notifications
- [ ] Social features
- [ ] Performance optimization

## 🤝 Contributing

1. Follow the established architecture
2. Maintain SquadUp branding guidelines
3. Write tests for new features
4. Ensure RTL support for Arabic
5. Follow the established code style

## 📄 License

This project is proprietary to SquadUp. All rights reserved.

---

**Built with ❤️ using Flutter and Clean Architecture**
