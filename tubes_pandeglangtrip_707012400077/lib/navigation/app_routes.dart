import 'package:flutter/material.dart';

import '../pages/detail_paket_page.dart';
import '../pages/form_pemesanan_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const beranda = '/';
  static const eksplorasi = '/eksplorasi';
  static const paketTur = '/paket-tur';
  static const tiketSaya = '/tiket-saya';
  static const detailPaket = '/detail-paket';
  static const formPemesanan = '/form-pemesanan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (_) => const KerangkaNavigasi(),
      eksplorasi: (_) => const KerangkaNavigasi(indeksAwal: 0),
      paketTur: (_) => const KerangkaNavigasi(indeksAwal: 1),
      tiketSaya: (_) => const KerangkaNavigasi(indeksAwal: 2),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    final id = settings.arguments;

    if (settings.name == detailPaket && id is String) {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => DetailPaketPage(idPaket: id),
      );
    }

    if (settings.name == formPemesanan && id is String) {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => FormPemesananPage(idPaket: id),
      );
    }

    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
        body: const Center(child: Text('Halaman yang diminta tidak tersedia.')),
      ),
    );
  }
}
