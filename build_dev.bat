@echo off
REM Script para compilar la app en modo desarrollo (Regiones de Occidente)
echo Compilando app para DESARROLLO (Regiones de Occidente)...
flutter build apk --dart-define=ENV_FILE=.env
echo.
echo ✅ Compilación completada para DESARROLLO
echo    Archivo: build\app\outputs\flutter-apk\app-release.apk
echo    Regiones: Occidente (La Paz, Cochabamba, Potosí)
pause