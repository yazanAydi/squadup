@echo off
echo 🔧 Fixing Color.withValues(alpha:) issues in SquadUp...
echo.

REM Find and replace in all Dart files
for /r %%f in (*.dart) do (
    if not "%%f"=="fix_color_issues.dart" (
        echo Processing: %%f
        powershell -Command "(Get-Content '%%f') -replace '\.withValues\(alpha:\s*([^)]+)\)', '.withOpacity($1)' | Set-Content '%%f'"
    )
)

echo.
echo ✅ Color fixes completed!
echo.
echo ⚠️  IMPORTANT: Now run these commands:
echo     flutter clean
echo     flutter pub get
echo.
echo 🚀 SquadUp should now compile without errors!
pause
