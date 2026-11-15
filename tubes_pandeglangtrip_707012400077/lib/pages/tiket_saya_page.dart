import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/paket_wisata.dart';
import '../model/pemesanan_model.dart';
import '../model/favorit_model.dart';
import '../theme/app_theme.dart';

class TiketSayaPage extends StatelessWidget {
  const TiketSayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PemesananModel>();

    final jumlahFavorit = context.watch<FavoritModel>().jumlah;

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Tiket Saya',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Pantau catatan pemesanan tiket wisata yang telah dibuat.',
          style: TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            Chip(label: Text('${model.jumlah} Pemesanan')),
            Chip(label: Text('$jumlahFavorit Paket Favorit')),
          ],
        ),
        const SizedBox(height: 20),
        if (model.semua.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(35),
              child: Column(
                children: [
                  Icon(
                    Icons.confirmation_number_outlined,
                    size: 45,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Belum ada pemesanan tiket.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else
          ...model.semua.map((pesanan) {
            final paket = KatalogPaket.cari(pesanan.idPaket);

            return Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pesanan.kode,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      paket?.nama ?? 'Paket tidak tersedia',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Pemesan: ${pesanan.nama}'),
                    Text('Sesi: ${pesanan.sesi}'),
                    const SizedBox(height: 10),
                    const Chip(label: Text('Pemesanan Tercatat')),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}
