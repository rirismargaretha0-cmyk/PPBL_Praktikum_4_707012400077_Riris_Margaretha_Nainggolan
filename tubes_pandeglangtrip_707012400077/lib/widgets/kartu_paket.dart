import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/paket_wisata.dart';
import '../model/favorit_model.dart';
import '../navigation/app_routes.dart';
import '../theme/app_theme.dart';

class KartuPaket extends StatelessWidget {
  final PaketWisata paket;

  const KartuPaket({super.key, required this.paket});

  @override
  Widget build(BuildContext context) {
    final favorit = context.watch<FavoritModel>().disukai(paket.id);

    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.detailPaket,
            arguments: paket.id,
          );
        },
        onLongPress: () {
          showModalBottomSheet<void>(
            context: context,
            showDragHandle: true,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paket.nama,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(paket.deskripsi),
                  const SizedBox(height: 12),
                  Text(formatRupiah(paket.harga)),
                ],
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.soft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.beach_access,
                  size: 35,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paket.nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      paket.lokasi,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatRupiah(paket.harga),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<FavoritModel>().ubah(paket.id);
                },
                icon: Icon(
                  favorit ? Icons.favorite : Icons.favorite_border,
                  color: favorit ? Colors.red : AppColors.primary,
                ),
                tooltip: 'Ubah favorit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
