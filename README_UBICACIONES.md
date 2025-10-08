# 🗺️ App Mapa con Regiones Configurables

Esta aplicación Flutter muestra múltiples ubicaciones agrupadas por regiones en un mapa de Google Maps, con la capacidad de seleccionar qué región mostrar mediante variables de entorno en tiempo de compilación.

## ✨ Características

- 🌄 **Regiones de Occidente**: La Paz, Cochabamba, Potosí
- 🌅 **Regiones de Oriente**: Santa Cruz, Trinidad, Riberalta  
- 🔧 Configuración mediante variables de entorno
- 🚀 Diferentes builds para diferentes regiones
- 🎯 Interfaz visual que indica qué región está activa
- 📍 Múltiples marcadores con colores distintivos
- 🔍 Vista automática que engloba todas las ubicaciones de la región

## 🛠️ Configuración

### Archivos de Configuración

- `.env` - Configuración por defecto (Regiones de Occidente)
- `.env.occidente` - Configuración para regiones de occidente
- `.env.oriente` - Configuración para regiones de oriente

### Variables de Entorno

```env
# API Key de Google Maps
GOOGLE_MAPS_API_KEY=tu_api_key_aqui

# Modo de región (OCCIDENTE o ORIENTE)
REGION_MODE=OCCIDENTE

# Configuración de región de occidente
OCCIDENTE_REGION_NAME=Regiones de Occidente
OCCIDENTE_1_LAT=-16.500000
OCCIDENTE_1_LNG=-68.150000
OCCIDENTE_1_NAME=La Paz
OCCIDENTE_2_LAT=-17.3935
OCCIDENTE_2_LNG=-66.1570
OCCIDENTE_2_NAME=Cochabamba
OCCIDENTE_3_LAT=-19.0448
OCCIDENTE_3_LNG=-65.2591
OCCIDENTE_3_NAME=Potosí

# Configuración de región de oriente
ORIENTE_REGION_NAME=Regiones de Oriente
ORIENTE_1_LAT=-17.7833
ORIENTE_1_LNG=-63.1821
ORIENTE_1_NAME=Santa Cruz
ORIENTE_2_LAT=-14.8333
ORIENTE_2_LNG=-64.9000
ORIENTE_2_NAME=Trinidad
ORIENTE_3_LAT=-12.5833
ORIENTE_3_LNG=-65.4167
ORIENTE_3_NAME=Riberalta
```

## 🚀 Compilación

### Opción 1: Scripts Automáticos (Windows)

```bash
# Scripts principales
build_dev.bat           # Desarrollo (Regiones de Occidente)
build_production.bat    # Producción (Regiones de Occidente)
build_staging.bat       # Staging (Regiones de Oriente)

# Scripts específicos por región  
build_occidente.bat     # Compilar regiones de occidente
build_oriente.bat       # Compilar regiones de oriente
```

### Opción 2: Scripts de Ejecución Rápida

```bash
# Ejecutar con regiones de occidente
run_occidente.bat

# Ejecutar con regiones de oriente  
run_oriente.bat
```

### Opción 3: Comandos Manuales

```bash
# Desarrollo - Regiones de Occidente
flutter run --dart-define=ENV_FILE=.env

# Regiones de Occidente
flutter build apk --dart-define=ENV_FILE=.env.occidente --release

# Regiones de Oriente
flutter build apk --dart-define=ENV_FILE=.env.oriente --release

# Ejecutar con regiones de oriente
flutter run --dart-define=ENV_FILE=.env.oriente
```

## 📱 Funcionamiento

### Regiones de Occidente
- **La Paz** (Marcador azul)
- **Cochabamba** (Marcador rojo)  
- **Potosí** (Marcador violeta)

### Regiones de Oriente
- **Santa Cruz** (Marcador verde)
- **Trinidad** (Marcador naranja)
- **Riberalta** (Marcador amarillo)

### Características Visuales
1. **Múltiples marcadores**: Cada región muestra todas sus ubicaciones simultáneamente
2. **Colores distintivos**: Diferentes colores según la región y ubicación
3. **Vista automática**: El mapa se ajusta para mostrar todas las ubicaciones de la región
4. **Indicador superior**: Muestra la región activa y cantidad de ubicaciones
5. **Lista de chips**: Resumen visual de todas las ubicaciones en la región

## 🔧 Personalización

### Cambiar Ubicaciones de una Región

Edita las coordenadas en cualquiera de los archivos `.env*`:

```env
# Para agregar una nueva ubicación de occidente
OCCIDENTE_4_LAT=tu_latitud
OCCIDENTE_4_LNG=tu_longitud  
OCCIDENTE_4_NAME=Nueva Ciudad
```

### Agregar Más Regiones

1. Agrega nuevas variables en los archivos `.env*`
2. Modifica `lib/config/location_config.dart` para incluir la nueva región
3. Actualiza la lógica en `lib/main.dart`

### Cambiar Colores de Marcadores

En `lib/main.dart`, método `_inicializarMarcadores()`, puedes cambiar:

```dart
BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
```

Colores disponibles: `hueRed`, `hueBlue`, `hueGreen`, `hueYellow`, `hueOrange`, `hueViolet`, etc.

## 🔑 Configuración de Google Maps

1. Obtén una API key de [Google Cloud Console](https://console.cloud.google.com/)
2. Habilita la Google Maps SDK para Android/iOS
3. Reemplaza `tu_api_key_aqui` en los archivos `.env*`

## 📂 Estructura del Proyecto

```
lib/
├── main.dart                    # Aplicación principal
├── config/
│   └── location_config.dart     # Configuración de regiones
.env                            # Config desarrollo (Occidente)
.env.occidente                  # Config regiones de occidente
.env.oriente                    # Config regiones de oriente
build_dev.bat                   # Script desarrollo
build_production.bat            # Script producción (occidente)
build_staging.bat               # Script staging (oriente)
build_occidente.bat             # Script específico occidente
build_oriente.bat               # Script específico oriente
run_occidente.bat              # Ejecutar regiones occidente
run_oriente.bat                # Ejecutar regiones oriente
```

## 🌍 Ubicaciones Predefinidas

### Regiones de Occidente (Altiplano y Valles)
- **La Paz**: Capital administrativa (-16.5000, -68.1500)
- **Cochabamba**: Ciudad jardín (-17.3935, -66.1570)
- **Potosí**: Ciudad imperial (-19.0448, -65.2591)

### Regiones de Oriente (Llanos)
- **Santa Cruz**: Capital económica (-17.7833, -63.1821)
- **Trinidad**: Capital del Beni (-14.8333, -64.9000)
- **Riberalta**: Puerta de la Amazonía (-12.5833, -65.4167)

## 🐛 Solución de Problemas

### Error: "No se encontró una configuración válida"
- Verifica que el archivo `.env` existe
- Asegúrate de que `GOOGLE_MAPS_API_KEY` no sea `tu_api_key_aqui`

### El mapa no se muestra
- Verifica tu API key de Google Maps
- Asegúrate de haber habilitado la Google Maps SDK

### La región no cambia
- Verifica que `REGION_MODE` esté configurado correctamente (`OCCIDENTE` o `ORIENTE`)
- Recompila la app después de cambiar la configuración

### No se muestran ubicaciones
- Verifica que las coordenadas estén correctamente configuradas
- Asegúrate de que los nombres de ubicación no estén vacíos

## 📄 Licencia

Este proyecto es de uso educativo y de demostración.