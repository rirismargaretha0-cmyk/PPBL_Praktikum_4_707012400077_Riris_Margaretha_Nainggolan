import 'package:flutter_test/flutter_test.dart';

import '../lib/model/favorit_model.dart';
import '../lib/model/pemesanan_model.dart';

void main() {
  test('Favorit berhasil ditambahkan', () {
    final model = FavoritModel();

    model.ubah('umang');

    expect(model.jumlah, 1);
    expect(model.disukai('umang'), true);
  });

  test('Pemesanan berhasil disimpan', () {
    final model = PemesananModel();

    model.tambah(
      idPaket: 'umang',
      nama: 'Budi',
      email: 'budi@gmail.com',
      sesi: 'Pagi',
    );

    expect(model.jumlah, 1);
  });
}
