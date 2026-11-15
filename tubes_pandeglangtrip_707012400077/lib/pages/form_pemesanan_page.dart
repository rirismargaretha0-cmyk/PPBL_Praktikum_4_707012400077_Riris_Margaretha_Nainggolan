import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/paket_wisata.dart';
import '../model/pemesanan_model.dart';
import '../navigation/app_routes.dart';
import '../theme/app_theme.dart';

class FormPemesananPage extends StatefulWidget {
  final String idPaket;

  const FormPemesananPage({super.key, required this.idPaket});

  @override
  State<FormPemesananPage> createState() => _FormPemesananPageState();
}

class _FormPemesananPageState extends State<FormPemesananPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();

  String? _sesi;
  bool _setuju = false;
  bool _mengirim = false;

  bool get _valid =>
      _namaController.text.trim().isNotEmpty &&
      _emailController.text.contains('@') &&
      _sesi != null &&
      _setuju;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _kirim() async {
    if (!_valid || _mengirim) return;

    final nama = _namaController.text.trim();
    final email = _emailController.text.trim();
    final sesi = _sesi!;

    setState(() => _mengirim = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    context.read<PemesananModel>().tambah(
      idPaket: widget.idPaket,
      nama: nama,
      email: email,
      sesi: sesi,
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.tiketSaya,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final paket = KatalogPaket.cari(widget.idPaket);

    if (paket == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Pemesanan Tiket')),
        body: const Center(child: Text('Paket tidak ditemukan.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Form Pemesanan Tiket')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paket.nama,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatRupiah(paket.harga),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 22),
                    TextField(
                      controller: _namaController,
                      enabled: !_mengirim,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _emailController,
                      enabled: !_mengirim,
                      onChanged: (_) => setState(() {}),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Pilih Sesi Kunjungan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    RadioGroup<String>(
                      groupValue: _sesi,
                      onChanged: (nilai) {
                        setState(() {
                          _sesi = nilai;
                        });
                      },
                      child: Column(
                        children: [
                          for (final sesi in ['Pagi', 'Siang', 'Sore'])
                            RadioListTile<String>(
                              title: Text('Sesi $sesi'),
                              value: sesi,
                              enabled: !_mengirim,
                            ),
                        ],
                      ),
                    ),
                    CheckboxListTile(
                      value: _setuju,
                      title: const Text(
                        'Saya menyetujui ketentuan pemesanan tiket.',
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: _mengirim
                          ? null
                          : (nilai) {
                              setState(() {
                                _setuju = nilai ?? false;
                              });
                            },
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _valid && !_mengirim ? _kirim : null,
                        icon: _mengirim
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.check_circle),
                        label: Text(
                          _mengirim
                              ? 'Sedang Memproses...'
                              : 'Konfirmasi Pemesanan',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
