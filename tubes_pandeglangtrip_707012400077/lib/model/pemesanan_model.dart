import 'package:flutter/foundation.dart';

class Pemesanan {
  final String kode;
  final String idPaket;
  final String nama;
  final String email;
  final String sesi;
  final DateTime tanggal;

  const Pemesanan({
    required this.kode,
    required this.idPaket,
    required this.nama,
    required this.email,
    required this.sesi,
    required this.tanggal,
  });
}

class PemesananModel extends ChangeNotifier {
  final List<Pemesanan> _daftar = [];

  List<Pemesanan> get semua => List.unmodifiable(_daftar);

  int get jumlah => _daftar.length;

  void tambah({
    required String idPaket,
    required String nama,
    required String email,
    required String sesi,
  }) {
    final kode = 'PT-${(_daftar.length + 1).toString().padLeft(3, '0')}';

    _daftar.insert(
      0,
      Pemesanan(
        kode: kode,
        idPaket: idPaket,
        nama: nama,
        email: email,
        sesi: sesi,
        tanggal: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
