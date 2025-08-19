# SquadUp Authentication Setup Guide

## New Authentication Features Added

### 1. Google Sign-In
- **Package**: `google_sign_in: ^6.2.1`
- **Setup Required**: 
  - Configure Google Sign-In in Firebase Console
  - Add SHA-1 fingerprint to Firebase project
  - Download and add `google-services.json` to `android/app/`

### 2. Apple Sign-In
- **Package**: `sign_in_with_apple: ^6.1.1`
- **Setup Required**:
  - Configure Apple Sign-In in Firebase Console
  - Add Apple Developer account configuration
  - Configure iOS bundle identifier

### 3. Biometric Authentication
- **Package**: `local_auth: ^2.2.0`
- **Setup Required**:
  - Add permissions to Android manifest
  - Configure iOS Info.plist
  - Handle device compatibility

## Android Setup

### 1. Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
<uses-permission android:name="android.permission.USE_FINGERPRINT" />
```

### 2. Add to `android/app/build.gradle.kts`:
```kotlin
android {
    defaultConfig {
        minSdkVersion 21
    }
}
```

## iOS Setup

### 1. Add to `ios/Runner/Info.plist`:
```xml
<key>NSFaceIDUsageDescription</key>
<string>This app uses Face ID to sign you in securely.</string>
```

### 2. Configure Apple Sign-In capabilities in Xcode

## Firebase Console Setup

### 1. Enable Authentication Methods:
- Email/Password
- Google
- Apple

### 2. Configure OAuth providers with proper redirect URIs

## Testing

### 1. Test on Physical Devices:
- Biometric authentication requires physical device
- Social login may require device-specific setup

### 2. Test Error Handling:
- Network failures
- User cancellation
- Invalid credentials

## Security Notes

- Biometric authentication is device-specific
- Social login tokens are managed by Firebase
- User data is stored securely in Firestore
- All authentication flows include proper error handling

## Troubleshooting

### Common Issues:
1. **Google Sign-In fails**: Check SHA-1 fingerprint and Firebase configuration
2. **Apple Sign-In fails**: Verify Apple Developer account and bundle ID
3. **Biometric not available**: Check device compatibility and permissions
4. **Build errors**: Ensure all dependencies are properly installed

### Debug Commands:
```bash
flutter clean
flutter pub get
flutter run --verbose
```
