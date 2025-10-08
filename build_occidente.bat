@echo off
REM Script para compilar la app para regiones de occidente
echo Compilando app para REGIONES DE OCCIDENTE...
flutter build apk --dart-define=ENV_FILE=.env.occidente --release
echo.
echo ✅ Compilación completada para REGIONES DE OCCIDENTE
echo    Archivo: build\app\outputs\flutter-apk\app-release.apk
echo    Regiones: La Paz, Cochabamba, Potosí
pause