@echo off
REM Script para compilar la app para regiones de oriente
echo Compilando app para REGIONES DE ORIENTE...
flutter build apk --dart-define=ENV_FILE=.env.oriente --release
echo.
echo ✅ Compilación completada para REGIONES DE ORIENTE
echo    Archivo: build\app\outputs\flutter-apk\app-release.apk
echo    Regiones: Santa Cruz, Trinidad, Riberalta
pause