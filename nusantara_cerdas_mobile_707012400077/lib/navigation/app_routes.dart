import 'package:flutter/material.dart';

import '../pages/detail_pengajuan_page.dart';
import '../pages/formulir_pengajuan_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String warga = '/warga';
  static const String layanan = '/layanan';
  static const String chat = '/chat';
  static const String lokasi = '/lokasi';
  static const String statistik = '/statistik';
  static const String pengajuanBaru = '/pengajuan-baru';
  static const String detailPengajuan = '/detail-pengajuan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (_) => const KerangkaNavigasi(),
      warga: (_) => const KerangkaNavigasi(indeksAwal: 0),
      layanan: (_) => const KerangkaNavigasi(indeksAwal: 1),
      chat: (_) => const KerangkaNavigasi(indeksAwal: 2),
      lokasi: (_) => const KerangkaNavigasi(indeksAwal: 3),
      statistik: (_) => const KerangkaNavigasi(indeksAwal: 4),
      pengajuanBaru: (_) => const FormulirPengajuanPage(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailPengajuan) {
      final id = settings.arguments;

      if (id is String) {
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DetailPengajuanPage(id: id),
        );
      }
    }

    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
        body: Center(child: Text('Route ${settings.name} tidak terdaftar.')),
      ),
    );
  }
}
