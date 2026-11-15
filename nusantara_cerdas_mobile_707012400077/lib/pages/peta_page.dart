import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../theme/app_colors.dart';

class PetaPage extends StatelessWidget {
  const PetaPage({super.key});

  static const LatLng _pusat = LatLng(-6.914744, 107.609810);

  static final Set<Marker> _penanda = {
    Marker(
      markerId: MarkerId('kantor_pusat'),
      position: LatLng(-6.914744, 107.609810),
      infoWindow: InfoWindow(title: 'Kantor Layanan Pusat'),
    ),
    Marker(
      markerId: MarkerId('kantor_utara'),
      position: LatLng(-6.894200, 107.616800),
      infoWindow: InfoWindow(title: 'Kantor Layanan Utara'),
    ),
    Marker(
      markerId: MarkerId('kantor_selatan'),
      position: LatLng(-6.941500, 107.605700),
      infoWindow: InfoWindow(title: 'Kantor Layanan Selatan'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Temukan Kantor Layanan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              const Text(
                'Peta berikut menampilkan tiga titik simulasi kantor layanan.',
                style: TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 420,
                  width: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: _pusat,
                      zoom: 12.5,
                    ),
                    markers: _penanda,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: true,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              ...const [
                'Kantor Layanan Pusat',
                'Kantor Layanan Utara',
                'Kantor Layanan Selatan',
              ].map(
                (nama) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    leading: const Icon(
                      Icons.location_on,
                      color: AppColors.teal,
                    ),
                    title: Text(nama),
                    subtitle: const Text('Lokasi simulasi layanan warga'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
