import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_ui/material_ui.dart';

class _PlaceData {
  const _PlaceData({
    required this.name,
    required this.description,
    required this.lat,
    required this.lng,
  });

  final String name;
  final String description;
  final double lat;
  final double lng;
}

class NearbyPage extends StatefulWidget {
  const NearbyPage({super.key});

  @override
  State<NearbyPage> createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  static const LatLng _center = LatLng(-5.0892, -42.8019); // Coordenadas de Teresina, Piauí

  static const List<_PlaceData> _places = [
    _PlaceData(
      name: 'IFPI - Campus Teresina Central',
      description: 'Instituto Federal do Piauí · 5 min a pé',
      lat: -5.0892,
      lng: -42.8019,
    ),
    _PlaceData(
      name: 'Café Cantinho',
      description: 'Cafeteria · aberto até 20h · 3 min a pé',
      lat: -5.0905,
      lng: -42.8032,
    ),
    _PlaceData(
      name: 'Restaurante Sabor Caseiro',
      description: 'Comida regional · a partir de R\$ 25 · 8 min a pé',
      lat: -5.0878,
      lng: -42.8005,
    ),
    _PlaceData(
      name: 'Hotel Rio Poty',
      description: 'Hospedagem · 4 estrelas · 10 min a pé',
      lat: -5.0915,
      lng: -42.8041,
    ),
  ];

  void _showPlaceInfo(_PlaceData place) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Text(
                place.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                place.description,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Set<Marker> get _markers {
    return _places.map((place) {
      return Marker(
        markerId: MarkerId(place.name),
        position: LatLng(place.lat, place.lng),
        infoWindow: InfoWindow(title: place.name, snippet: place.description),
        onTap: () => _showPlaceInfo(place),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _center,
          zoom: 15,
        ),
        markers: _markers,
      ),
    );
  }
}
