@echo off
REM Script para compilar la app en modo staging (Regiones de Oriente)
echo Compilando app para STAGING (Regiones de Oriente)...
flutter build apk --dart-define=ENV_FILE=.env.oriente --release
echo.
echo ✅ Compilación completada para STAGING
echo    Archivo: build\app\outputs\flutter-apk\app-release.apk
echo    Regiones: Oriente (Santa Cruz, Trinidad, Riberalta)
pause