import 'package:flutter/foundation.dart';

class Pengajuan {
  final String id;
  final String nama;
  final String email;
  final String bidang;
  final String sesi;
  final DateTime tanggal;
  final bool selesai;

  const Pengajuan({
    required this.id,
    required this.nama,
    required this.email,
    required this.bidang,
    required this.sesi,
    required this.tanggal,
    this.selesai = false,
  });

  Pengajuan copyWith({bool? selesai}) {
    return Pengajuan(
      id: id,
      nama: nama,
      email: email,
      bidang: bidang,
      sesi: sesi,
      tanggal: tanggal,
      selesai: selesai ?? this.selesai,
    );
  }
}

class PengajuanModel extends ChangeNotifier {
  static const List<String> bidangTersedia = [
    'Administrasi',
    'Kesehatan',
    'Pendidikan',
  ];

  final List<Pengajuan> _daftar = [];
  int _nomorTerakhir = 0;

  List<Pengajuan> get semua => List.unmodifiable(_daftar);

  int get total => _daftar.length;

  int get jumlahSelesai => _daftar.where((item) => item.selesai).length;

  int get jumlahDiproses => total - jumlahSelesai;

  int jumlahBidang(String bidang) {
    return _daftar.where((item) => item.bidang == bidang).length;
  }

  Pengajuan? cari(String id) {
    for (final item in _daftar) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  void tambah({
    required String nama,
    required String email,
    required String bidang,
    required String sesi,
  }) {
    _nomorTerakhir++;

    final pengajuan = Pengajuan(
      id: 'NCM-${_nomorTerakhir.toString().padLeft(3, '0')}',
      nama: nama,
      email: email,
      bidang: bidang,
      sesi: sesi,
      tanggal: DateTime.now(),
    );

    _daftar.insert(0, pengajuan);
    notifyListeners();
  }

  bool tandaiSelesai(String id) {
    final index = _daftar.indexWhere((item) => item.id == id);

    if (index == -1 || _daftar[index].selesai) {
      return false;
    }

    _daftar[index] = _daftar[index].copyWith(selesai: true);

    notifyListeners();
    return true;
  }
}
