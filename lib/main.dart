import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // Asegurar que Flutter esté inicializado
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Cargar variables de entorno
    await dotenv.load(fileName: ".env");
    
    // Verificar que tengamos una API key válida
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    if (apiKey.isEmpty || apiKey == 'tu_api_key_aqui') {
      print('⚠️  ADVERTENCIA: No se encontró una API key válida de Google Maps');
      print('   Edita el archivo .env y agrega tu API key real');
    }
  } catch (e) {
    print('❌ Error cargando archivo .env: $e');
    print('   Asegúrate de que el archivo .env existe en la raíz del proyecto');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapa con dos ubicaciones',
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

  // Coordenadas de dos ubicaciones
  final LatLng ubicacion1 = LatLng(-16.500000, -68.150000); // La Paz
  final LatLng ubicacion2 = LatLng(-17.3935, -66.1570); // Cochabamba

  final Set<Marker> _marcadores = {};

  @override
  void initState() {
    super.initState();
    _marcadores.addAll([
      Marker(
        markerId: MarkerId("ubicacion1"),
        position: ubicacion1,
        infoWindow: InfoWindow(title: "La Paz"),
      ),
      Marker(
        markerId: MarkerId("ubicacion2"),
        position: ubicacion2,
        infoWindow: InfoWindow(title: "Cochabamba"),
      ),
    ]);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // Centrar el mapa entre ambas ubicaciones (usando LatLngBounds)
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        ubicacion1.latitude < ubicacion2.latitude ? ubicacion1.latitude : ubicacion2.latitude,
        ubicacion1.longitude < ubicacion2.longitude ? ubicacion1.longitude : ubicacion2.longitude,
      ),
      northeast: LatLng(
        ubicacion1.latitude > ubicacion2.latitude ? ubicacion1.latitude : ubicacion2.latitude,
        ubicacion1.longitude > ubicacion2.longitude ? ubicacion1.longitude : ubicacion2.longitude,
      ),
    );

    Future.delayed(Duration(milliseconds: 100), () {
      mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dos ubicaciones en mapa")),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: ubicacion1,
          zoom: 6.0,
        ),
        markers: _marcadores,
      ),
    );
  }
}