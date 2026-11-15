class PaketWisata {
  final String id;
  final String nama;
  final String lokasi;
  final String deskripsi;
  final int harga;

  const PaketWisata({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.deskripsi,
    required this.harga,
  });
}

class KatalogPaket {
  static const List<PaketWisata> semua = [
    PaketWisata(
      id: 'umang',
      nama: 'Pulau Umang Resort & Beach',
      lokasi: 'Kecamatan Sumur, Pandeglang',
      deskripsi:
          'Paket wisata pantai dengan pemandangan laut dan suasana resort.',
      harga: 250000,
    ),
    PaketWisata(
      id: 'ujung_kulon',
      nama: 'Taman Nasional Ujung Kulon',
      lokasi: 'Kecamatan Sumur, Pandeglang',
      deskripsi: 'Paket eksplorasi wisata alam dan kawasan konservasi.',
      harga: 175000,
    ),
    PaketWisata(
      id: 'carita',
      nama: 'Pantai Carita',
      lokasi: 'Kecamatan Carita, Pandeglang',
      deskripsi: 'Paket wisata pantai untuk menikmati suasana pesisir.',
      harga: 95000,
    ),
  ];

  static PaketWisata? cari(String id) {
    for (final paket in semua) {
      if (paket.id == id) {
        return paket;
      }
    }
    return null;
  }
}

String formatRupiah(int nominal) {
  final angka = nominal.toString();
  final hasil = StringBuffer('Rp ');

  for (int i = 0; i < angka.length; i++) {
    if (i > 0 && (angka.length - i) % 3 == 0) {
      hasil.write('.');
    }
    hasil.write(angka[i]);
  }

  return hasil.toString();
}
