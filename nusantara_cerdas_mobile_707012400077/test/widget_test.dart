import 'package:flutter_test/flutter_test.dart';

import '../lib/model/pengajuan_model.dart';

void main() {
  test('Pengajuan berhasil ditambahkan', () {
    final model = PengajuanModel();

    model.tambah(
      nama: 'Budi',
      email: 'budi@gmail.com',
      bidang: 'Administrasi',
      sesi: 'Pagi',
    );

    expect(model.total, 1);
    expect(model.jumlahBidang('Administrasi'), 1);
    expect(model.jumlahDiproses, 1);
  });
}
