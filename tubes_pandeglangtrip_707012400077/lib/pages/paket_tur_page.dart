import 'package:flutter/material.dart';

import '../model/paket_wisata.dart';
import '../widgets/kartu_paket.dart';
import '../theme/app_theme.dart';

class PaketTurPage extends StatelessWidget {
  const PaketTurPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilih Paket Wisata',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Temukan pilihan wisata dan paket tur sesuai kebutuhan.',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 12),
                Chip(
                  label: Text('${KatalogPaket.semua.length} Paket Tersedia'),
                ),
                const SizedBox(height: 18),
                ...KatalogPaket.semua.map((paket) => KartuPaket(paket: paket)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
