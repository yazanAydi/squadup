@echo off
echo Installing SquadUp dependencies...
echo.

echo Installing Flutter dependencies...
flutter pub get

echo.
echo Installing development dependencies...
flutter pub get --dev

echo.
echo Running build runner to generate code...
flutter packages pub run build_runner build

echo.
echo Dependencies installed successfully!
echo.
echo Next steps:
echo 1. Run 'flutter doctor' to verify setup
echo 2. Run 'flutter test' to run tests
echo 3. Run 'flutter run' to start the app
echo.
pause
