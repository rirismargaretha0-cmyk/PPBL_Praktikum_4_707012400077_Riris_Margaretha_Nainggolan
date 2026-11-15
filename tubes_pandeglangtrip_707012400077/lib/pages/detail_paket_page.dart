import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/paket_wisata.dart';
import '../model/favorit_model.dart';
import '../navigation/app_routes.dart';
import '../theme/app_theme.dart';

class DetailPaketPage extends StatefulWidget {
  final String idPaket;

  const DetailPaketPage({super.key, required this.idPaket});

  @override
  State<DetailPaketPage> createState() => _DetailPaketPageState();
}

class _DetailPaketPageState extends State<DetailPaketPage> {
  bool _infoTerbuka = false;

  @override
  Widget build(BuildContext context) {
    final paket = KatalogPaket.cari(widget.idPaket);

    if (paket == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Paket')),
        body: const Center(child: Text('Paket tidak ditemukan.')),
      );
    }

    final favorit = context.watch<FavoritModel>().disukai(paket.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Paket & Tiket Tur'),
        actions: [
          IconButton(
            tooltip: 'Favorit',
            onPressed: () {
              context.read<FavoritModel>().ubah(paket.id);
            },
            icon: Icon(
              favorit ? Icons.favorite : Icons.favorite_border,
              color: favorit ? Colors.redAccent : Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Chip(label: Text('Paket 1 Hari Tur')),
                const SizedBox(height: 12),
                Text(
                  paket.nama,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Expanded(child: Text(paket.lokasi)),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  color: AppColors.soft,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const ListTile(
                          leading: Icon(Icons.confirmation_number),
                          title: Text('Tarif Paket / Orang'),
                        ),
                        Text(
                          formatRupiah(paket.harga),
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const Divider(),
                        const ListTile(
                          leading: Icon(Icons.receipt_long),
                          title: Text('Catatan pemesanan digital'),
                          subtitle: Text(
                            'Tersimpan pada menu Tiket Saya setelah konfirmasi.',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Fasilitas & Keterangan Tur',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(paket.deskripsi),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _infoTerbuka = !_infoTerbuka;
                    });
                  },
                  icon: Icon(
                    _infoTerbuka ? Icons.expand_less : Icons.info_outline,
                  ),
                  label: Text(_infoTerbuka ? 'Tutup Info' : 'Info Paket'),
                ),
                if (_infoTerbuka)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.soft,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      'Pilih sesi kunjungan pada formulir pemesanan. Harga dan fasilitas pada aplikasi ini merupakan data simulasi untuk kebutuhan praktikum.',
                    ),
                  ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.formPemesanan,
                arguments: paket.id,
              );
            },
            icon: const Icon(Icons.shopping_bag_outlined),
            label: const Text('Pesan Tiket'),
          ),
        ),
      ),
    );
  }
}
