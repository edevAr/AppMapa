import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/location_config.dart';

Future<void> main() async {
  // Asegurar que Flutter esté inicializado
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Cargar variables de entorno
    // Se puede especificar un archivo diferente usando --dart-define=ENV_FILE=.env.production
    const String envFile = String.fromEnvironment('ENV_FILE', defaultValue: '.env');
    await dotenv.load(fileName: envFile);
    
    // Imprimir información de configuración
    RegionConfig.printDebugInfo();
    
    // Verificar que tengamos una API key válida
    if (!RegionConfig.isConfigValid) {
      print('⚠️  ADVERTENCIA: No se encontró una configuración válida');
      print('   Edita el archivo $envFile y agrega tu API key real');
    } else {
      print('✅ Configuración cargada correctamente desde: $envFile');
    }
  } catch (e) {
    print('❌ Error cargando archivo de configuración: $e');
    print('   Asegúrate de que el archivo .env existe en la raíz del proyecto');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapa de Regiones - ${RegionConfig.activeRegionName}',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MapaScreen(),
    );
  }
}

class MapaScreen extends StatefulWidget {
  @override
  _MapaScreenState createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _marcadores = {};

  @override
  void initState() {
    super.initState();
    _inicializarMarcadores();
  }

  void _inicializarMarcadores() {
    // Obtener las ubicaciones de la región activa
    final ubicacionesRegion = RegionConfig.activeRegionLocations;
    
    // Limpiar marcadores existentes
    _marcadores.clear();
    
    // Agregar marcadores para todas las ubicaciones de la región activa
    for (int i = 0; i < ubicacionesRegion.length; i++) {
      final ubicacion = ubicacionesRegion[i];
      
      // Definir colores diferentes para cada marcador
      BitmapDescriptor iconColor;
      switch (i % 3) {
        case 0:
          iconColor = RegionConfig.regionMode == 'ORIENTE' 
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
          break;
        case 1:
          iconColor = RegionConfig.regionMode == 'ORIENTE'
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
          break;
        default:
          iconColor = RegionConfig.regionMode == 'ORIENTE'
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
          break;
      }
      
      _marcadores.add(
        Marker(
          markerId: MarkerId(ubicacion.id),
          position: ubicacion.position,
          infoWindow: InfoWindow(
            title: ubicacion.name,
            snippet: '${RegionConfig.activeRegionName} (${i + 1}/${ubicacionesRegion.length})',
          ),
          icon: iconColor,
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // Obtener las ubicaciones de la región activa
    final ubicacionesRegion = RegionConfig.activeRegionLocations;
    
    if (ubicacionesRegion.isNotEmpty) {
      // Si hay múltiples ubicaciones, ajustar la vista para mostrar todas
      if (ubicacionesRegion.length > 1) {
        final bounds = RegionConfig.calculateBounds(ubicacionesRegion);
        if (bounds != null) {
          Future.delayed(const Duration(milliseconds: 300), () {
            mapController.animateCamera(
              CameraUpdate.newLatLngBounds(bounds, 100.0),
            );
          });
        }
      } else {
        // Si hay solo una ubicación, centrar en ella
        Future.delayed(const Duration(milliseconds: 300), () {
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(ubicacionesRegion.first.position, 12.0),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ubicacionesRegion = RegionConfig.activeRegionLocations;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(RegionConfig.activeRegionName),
        backgroundColor: RegionConfig.regionMode == 'ORIENTE' 
            ? Colors.green[600] 
            : Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Indicador de configuración
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: RegionConfig.regionMode == 'ORIENTE' 
                  ? Colors.green[50] 
                  : Colors.blue[50],
              border: Border(
                bottom: BorderSide(
                  color: RegionConfig.regionMode == 'ORIENTE' 
                      ? Colors.green[200]! 
                      : Colors.blue[200]!,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Región: ${RegionConfig.regionMode}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: RegionConfig.regionMode == 'ORIENTE' 
                        ? Colors.green[800] 
                        : Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${ubicacionesRegion.length} ubicaciones configuradas',
                  style: TextStyle(
                    fontSize: 12,
                    color: RegionConfig.regionMode == 'ORIENTE' 
                        ? Colors.green[600] 
                        : Colors.blue[600],
                  ),
                ),
              ],
            ),
          ),
          // Lista de ubicaciones
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            color: Colors.grey[50],
            child: Wrap(
              spacing: 8.0,
              children: ubicacionesRegion.map((ubicacion) {
                return Chip(
                  label: Text(
                    ubicacion.name,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: RegionConfig.regionMode == 'ORIENTE' 
                      ? Colors.green[100] 
                      : Colors.blue[100],
                  side: BorderSide(
                    color: RegionConfig.regionMode == 'ORIENTE' 
                        ? Colors.green[300]! 
                        : Colors.blue[300]!,
                  ),
                );
              }).toList(),
            ),
          ),
          // Mapa
          Expanded(
            child: ubicacionesRegion.isNotEmpty
                ? GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: ubicacionesRegion.first.position,
                      zoom: 8.0,
                    ),
                    markers: _marcadores,
                  )
                : Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_off,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No hay ubicaciones configuradas\npara esta región',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}