@echo off
echo 🔧 Fixing deprecated withOpacity() calls in SquadUp...
echo.

REM Find and replace in all Dart files
for /r %%f in (*.dart) do (
    if not "%%f"=="fix_*" (
        echo Processing: %%f
        powershell -Command "(Get-Content '%%f') -replace '\.withOpacity\(([^)]+)\)', '.withValues(alpha: $1)' | Set-Content '%%f'"
    )
)

echo.
echo ✅ withOpacity deprecation fixes completed!
echo.
echo ⚠️  IMPORTANT: Now run these commands:
echo     flutter clean
echo     flutter pub get
echo.
echo 🚀 SquadUp should now use the correct withValues(alpha:) syntax!
pause

