# ================================
# SquadUp Cursor Rules
# ================================

# --- General ---
- All code must be written in **Dart (Flutter)**.
- Follow **Clean Architecture**: presentation/, domain/, data/
- No direct Firebase calls in UI (presentation) layer — only through repositories.
- All features must support **offline mode** with Firestore caching.
- All strings must use **intl localization** (no hardcoded text).
- Every UI must support **RTL (Arabic)** and **LTR (English)** layouts.

# --- State Management ---
- Use **Riverpod** for state management.
- Providers go in `lib/presentation/providers/`.
- Business logic in `lib/domain/usecases/`.
- Repositories defined in `lib/domain/repositories/`, implemented in `lib/data/repositories/`.

# --- Theming & Branding ---
- Apply **SquadUp theme**:
  - Primary: #8B5CF6
  - Background: #0F0A1F
  - Card: #1C1532
  - Text primary: #FFFFFF
  - Text secondary: #A1A1AA
  - Accent glow: #7C3AED
- Fonts: **Poppins/Roboto** (English), **Noto Sans Arabic** (Arabic).
- All buttons rounded radius = 16.
- Inputs filled with #1C1532, icons in #8B5CF6.
- Logo: assets/images/logo.png must be used in Splash + App Icon.

# --- Testing ---
- Minimum **70% unit test coverage** for repositories, models, and use cases.
- Add **widget tests** for screens (happy path + validation errors).
- Add **golden tests** for all major screens in both Arabic (RTL) and English (LTR).
- For Firebase Security Rules → test with Emulator.

# --- Firebase ---
- Use Firebase Emulators for local dev (Auth, Firestore, Functions).
- Config/secrets must come from `.env`, never hardcoded.
- Security rules: users can only read/write their own data; games writable by creator/players.

# --- Code Style ---
- Run `dart format` on save.
- Run `flutter analyze` must pass with no warnings.
- No unused imports, no dead code.
- Use **Freezed** + **JsonSerializable** for models.

# --- Git & CI ---
- Git workflow: feature branches → PR → review → main.
- Every PR must pass: `flutter test`, `flutter analyze`, golden tests.
- CI/CD: GitHub Actions + Firebase App Distribution for beta.

# --- UX Rules ---
- Splash screen fades into Sign In in 2s.
- Sign In/Onboarding must always offer language choice (Arabic/English).
- No screen is “English-only.”
- Always show fallback content when offline (cached data).
