import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/paket_wisata.dart';
import '../model/favorit_model.dart';
import '../model/pemesanan_model.dart';
import '../widgets/kartu_paket.dart';
import '../theme/app_theme.dart';

class EksplorasiPage extends StatelessWidget {
  const EksplorasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jumlahFavorit = context.watch<FavoritModel>().jumlah;
    final jumlahPemesanan = context.watch<PemesananModel>().jumlah;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.dark, AppColors.primary],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.sailing, color: Colors.white, size: 30),
                    SizedBox(height: 12),
                    Text(
                      'PANDEGLANGTRIP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Pesona Wisata Bahari & Konservasi Alam',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Jelajahi Keindahan Kabupaten Pandeglang',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Chip(
                    avatar: const Icon(
                      Icons.favorite,
                      color: AppColors.primary,
                    ),
                    label: Text('$jumlahFavorit paket favorit tersimpan'),
                  ),
                  Chip(
                    avatar: const Icon(
                      Icons.confirmation_number,
                      color: AppColors.primary,
                    ),
                    label: Text('$jumlahPemesanan pemesanan tercatat'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Destinasi Wisata Populer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...KatalogPaket.semua.map((paket) => KartuPaket(paket: paket)),
            ],
          ),
        ),
      ),
    );
  }
}
