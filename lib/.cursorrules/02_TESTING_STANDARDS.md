# Testing Standards

Targets:
- Unit coverage ≥ 70% for domain + repositories + usecases.
- Widget tests for form validation/flows.
- Golden tests for major screens in AR (RTL) + EN (LTR) with dark theme.
- Emulator tests for Firestore security rules and auth flows.

Conventions:
- Provide `pumpLocalizedWidget` helper.
- Golden baselines under `test/golden/_goldens/`.
- Tag goldens with `@Tags(['golden'])`.
