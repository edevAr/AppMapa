@echo off
REM Script para compilar la app en modo producción (Regiones de Occidente)
echo Compilando app para PRODUCCIÓN (Regiones de Occidente)...
flutter build apk --dart-define=ENV_FILE=.env.occidente --release
echo.
echo ✅ Compilación completada para PRODUCCIÓN
echo    Archivo: build\app\outputs\flutter-apk\app-release.apk
echo    Regiones: Occidente (La Paz, Cochabamba, Potosí)
pause