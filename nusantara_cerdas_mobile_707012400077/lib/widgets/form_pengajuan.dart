import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';
import '../theme/app_colors.dart';

class FormPengajuan extends StatefulWidget {
  const FormPengajuan({super.key});

  @override
  State<FormPengajuan> createState() => _FormPengajuanState();
}

class _FormPengajuanState extends State<FormPengajuan> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();

  String _bidang = PengajuanModel.bidangTersedia.first;
  String? _sesi;
  bool _setuju = false;
  bool _sedangMengirim = false;

  bool get _formValid {
    return _namaController.text.trim().isNotEmpty &&
        _emailController.text.trim().contains('@') &&
        _setuju &&
        _sesi != null;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _kirimPengajuan() async {
    if (!_formValid || _sedangMengirim) return;

    final nama = _namaController.text.trim();
    final email = _emailController.text.trim();
    final bidang = _bidang;
    final sesi = _sesi!;
    final model = context.read<PengajuanModel>();

    setState(() {
      _sedangMengirim = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    model.tambah(nama: nama, email: email, bidang: bidang, sesi: sesi);

    _namaController.clear();
    _emailController.clear();

    setState(() {
      _setuju = false;
      _sesi = null;
      _sedangMengirim = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pengajuan berhasil disimpan.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data Pemohon',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        const Text(
          'Lengkapi data berikut untuk mengajukan layanan.',
          style: TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _namaController,
          enabled: !_sedangMengirim,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            labelText: 'Nama Lengkap',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _emailController,
          enabled: !_sedangMengirim,
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: const Icon(Icons.mail_outline),
            helperText: 'Email harus mengandung karakter @.',
            errorText:
                _emailController.text.isNotEmpty &&
                    !_emailController.text.contains('@')
                ? 'Format email belum sesuai.'
                : null,
          ),
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: _bidang,
          isExpanded: true,
          decoration: const InputDecoration(
            labelText: 'Bidang Layanan',
            prefixIcon: Icon(Icons.account_balance_outlined),
          ),
          items: PengajuanModel.bidangTersedia
              .map(
                (bidang) => DropdownMenuItem<String>(
                  value: bidang,
                  child: Text(bidang),
                ),
              )
              .toList(),
          onChanged: _sedangMengirim
              ? null
              : (nilai) {
                  if (nilai != null) {
                    setState(() {
                      _bidang = nilai;
                    });
                  }
                },
        ),
        const SizedBox(height: 20),
        const Text(
          'Pilih Sesi Kunjungan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        RadioGroup<String>(
          groupValue: _sesi,
          onChanged: (nilai) {
            setState(() {
              _sesi = nilai;
            });
          },
          child: Column(
            children: ['Pagi', 'Siang', 'Sore']
                .map(
                  (sesi) => RadioListTile<String>(
                    title: Text('Sesi $sesi'),
                    value: sesi,
                    enabled: !_sedangMengirim,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.primary,
                  ),
                )
                .toList(),
          ),
        ),
        const Divider(),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: _setuju,
          activeColor: AppColors.teal,
          title: const Text(
            'Saya menyetujui penggunaan data pribadi untuk pengajuan layanan.',
            style: TextStyle(fontSize: 13),
          ),
          onChanged: _sedangMengirim
              ? null
              : (nilai) {
                  setState(() {
                    _setuju = nilai ?? false;
                  });
                },
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _formValid && !_sedangMengirim ? _kirimPengajuan : null,
            icon: _sedangMengirim
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : const Icon(Icons.send_rounded),
            label: Text(
              _sedangMengirim ? 'Sedang mengirim...' : 'Kirim Pengajuan',
            ),
          ),
        ),
      ],
    );
  }
}
