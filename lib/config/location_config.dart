import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RegionConfig {
  static const String _regionModeKey = 'REGION_MODE';
  static const String _apiKeyKey = 'GOOGLE_MAPS_API_KEY';
  
  // Claves para regiones de occidente
  static const String _occidenteRegionNameKey = 'OCCIDENTE_REGION_NAME';
  static const String _occidente1LatKey = 'OCCIDENTE_1_LAT';
  static const String _occidente1LngKey = 'OCCIDENTE_1_LNG';
  static const String _occidente1NameKey = 'OCCIDENTE_1_NAME';
  static const String _occidente2LatKey = 'OCCIDENTE_2_LAT';
  static const String _occidente2LngKey = 'OCCIDENTE_2_LNG';
  static const String _occidente2NameKey = 'OCCIDENTE_2_NAME';
  static const String _occidente3LatKey = 'OCCIDENTE_3_LAT';
  static const String _occidente3LngKey = 'OCCIDENTE_3_LNG';
  static const String _occidente3NameKey = 'OCCIDENTE_3_NAME';
  
  // Claves para regiones de oriente
  static const String _orienteRegionNameKey = 'ORIENTE_REGION_NAME';
  static const String _oriente1LatKey = 'ORIENTE_1_LAT';
  static const String _oriente1LngKey = 'ORIENTE_1_LNG';
  static const String _oriente1NameKey = 'ORIENTE_1_NAME';
  static const String _oriente2LatKey = 'ORIENTE_2_LAT';
  static const String _oriente2LngKey = 'ORIENTE_2_LNG';
  static const String _oriente2NameKey = 'ORIENTE_2_NAME';
  static const String _oriente3LatKey = 'ORIENTE_3_LAT';
  static const String _oriente3LngKey = 'ORIENTE_3_LNG';
  static const String _oriente3NameKey = 'ORIENTE_3_NAME';

  /// Obtiene el modo de región configurado
  static String get regionMode => dotenv.env[_regionModeKey] ?? 'OCCIDENTE';

  /// Obtiene la API key de Google Maps
  static String get googleMapsApiKey => dotenv.env[_apiKeyKey] ?? '';

  /// Obtiene el nombre de la región activa
  static String get activeRegionName {
    if (regionMode == 'ORIENTE') {
      return dotenv.env[_orienteRegionNameKey] ?? 'Regiones de Oriente';
    }
    return dotenv.env[_occidenteRegionNameKey] ?? 'Regiones de Occidente';
  }

  /// Obtiene todas las ubicaciones de occidente
  static List<LocationData> get occidenteLocations {
    List<LocationData> locations = [];
    
    // Ubicación 1 de occidente
    final lat1 = double.tryParse(dotenv.env[_occidente1LatKey] ?? '');
    final lng1 = double.tryParse(dotenv.env[_occidente1LngKey] ?? '');
    final name1 = dotenv.env[_occidente1NameKey] ?? '';
    if (lat1 != null && lng1 != null && name1.isNotEmpty) {
      locations.add(LocationData(
        id: 'occidente_1',
        name: name1,
        position: LatLng(lat1, lng1),
        region: 'OCCIDENTE',
      ));
    }
    
    // Ubicación 2 de occidente
    final lat2 = double.tryParse(dotenv.env[_occidente2LatKey] ?? '');
    final lng2 = double.tryParse(dotenv.env[_occidente2LngKey] ?? '');
    final name2 = dotenv.env[_occidente2NameKey] ?? '';
    if (lat2 != null && lng2 != null && name2.isNotEmpty) {
      locations.add(LocationData(
        id: 'occidente_2',
        name: name2,
        position: LatLng(lat2, lng2),
        region: 'OCCIDENTE',
      ));
    }
    
    // Ubicación 3 de occidente
    final lat3 = double.tryParse(dotenv.env[_occidente3LatKey] ?? '');
    final lng3 = double.tryParse(dotenv.env[_occidente3LngKey] ?? '');
    final name3 = dotenv.env[_occidente3NameKey] ?? '';
    if (lat3 != null && lng3 != null && name3.isNotEmpty) {
      locations.add(LocationData(
        id: 'occidente_3',
        name: name3,
        position: LatLng(lat3, lng3),
        region: 'OCCIDENTE',
      ));
    }
    
    return locations;
  }

  /// Obtiene todas las ubicaciones de oriente
  static List<LocationData> get orienteLocations {
    List<LocationData> locations = [];
    
    // Ubicación 1 de oriente
    final lat1 = double.tryParse(dotenv.env[_oriente1LatKey] ?? '');
    final lng1 = double.tryParse(dotenv.env[_oriente1LngKey] ?? '');
    final name1 = dotenv.env[_oriente1NameKey] ?? '';
    if (lat1 != null && lng1 != null && name1.isNotEmpty) {
      locations.add(LocationData(
        id: 'oriente_1',
        name: name1,
        position: LatLng(lat1, lng1),
        region: 'ORIENTE',
      ));
    }
    
    // Ubicación 2 de oriente
    final lat2 = double.tryParse(dotenv.env[_oriente2LatKey] ?? '');
    final lng2 = double.tryParse(dotenv.env[_oriente2LngKey] ?? '');
    final name2 = dotenv.env[_oriente2NameKey] ?? '';
    if (lat2 != null && lng2 != null && name2.isNotEmpty) {
      locations.add(LocationData(
        id: 'oriente_2',
        name: name2,
        position: LatLng(lat2, lng2),
        region: 'ORIENTE',
      ));
    }
    
    // Ubicación 3 de oriente
    final lat3 = double.tryParse(dotenv.env[_oriente3LatKey] ?? '');
    final lng3 = double.tryParse(dotenv.env[_oriente3LngKey] ?? '');
    final name3 = dotenv.env[_oriente3NameKey] ?? '';
    if (lat3 != null && lng3 != null && name3.isNotEmpty) {
      locations.add(LocationData(
        id: 'oriente_3',
        name: name3,
        position: LatLng(lat3, lng3),
        region: 'ORIENTE',
      ));
    }
    
    return locations;
  }

  /// Obtiene las ubicaciones de la región activa
  static List<LocationData> get activeRegionLocations {
    return regionMode == 'ORIENTE' ? orienteLocations : occidenteLocations;
  }

  /// Obtiene todas las ubicaciones configuradas
  static List<LocationData> get allLocations {
    List<LocationData> all = [];
    all.addAll(occidenteLocations);
    all.addAll(orienteLocations);
    return all;
  }

  /// Calcula los límites geográficos para una lista de ubicaciones
  static LatLngBounds? calculateBounds(List<LocationData> locations) {
    if (locations.isEmpty) return null;

    double minLat = locations.first.position.latitude;
    double maxLat = locations.first.position.latitude;
    double minLng = locations.first.position.longitude;
    double maxLng = locations.first.position.longitude;

    for (var location in locations) {
      minLat = minLat < location.position.latitude ? minLat : location.position.latitude;
      maxLat = maxLat > location.position.latitude ? maxLat : location.position.latitude;
      minLng = minLng < location.position.longitude ? minLng : location.position.longitude;
      maxLng = maxLng > location.position.longitude ? maxLng : location.position.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  /// Verifica si la configuración es válida
  static bool get isConfigValid {
    return googleMapsApiKey.isNotEmpty && 
           googleMapsApiKey != 'tu_api_key_aqui' &&
           regionMode.isNotEmpty &&
           activeRegionLocations.isNotEmpty;
  }

  /// Imprime información de debug sobre la configuración
  static void printDebugInfo() {
    print('🔧 Configuración de regiones:');
    print('   Modo: $regionMode');
    print('   Región activa: $activeRegionName');
    print('   Ubicaciones en región activa: ${activeRegionLocations.length}');
    
    for (var location in activeRegionLocations) {
      print('     - ${location.name} (${location.position.latitude}, ${location.position.longitude})');
    }
    
    print('   API Key configurada: ${googleMapsApiKey.isNotEmpty ? 'Sí' : 'No'}');
    print('   Configuración válida: $isConfigValid');
  }
}

class LocationData {
  final String id;
  final String name;
  final LatLng position;
  final String region;

  LocationData({
    required this.id,
    required this.name,
    required this.position,
    required this.region,
  });
}