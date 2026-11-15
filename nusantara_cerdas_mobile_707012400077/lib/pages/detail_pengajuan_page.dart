import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';
import '../theme/app_colors.dart';

class DetailPengajuanPage extends StatelessWidget {
  final String id;

  const DetailPengajuanPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final pengajuan = context.watch<PengajuanModel>().cari(id);

    if (pengajuan == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Pengajuan')),
        body: const Center(child: Text('Data pengajuan tidak ditemukan.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengajuan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.receipt_long,
                      size: 38,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      pengajuan.bidang,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _BarisDetail('ID Pengajuan', pengajuan.id),
                    _BarisDetail('Nama Pemohon', pengajuan.nama),
                    _BarisDetail('Email', pengajuan.email),
                    _BarisDetail('Sesi Kunjungan', pengajuan.sesi),
                    _BarisDetail(
                      'Tanggal Pengajuan',
                      pengajuan.tanggal.toLocal().toString().substring(0, 16),
                    ),
                    _BarisDetail(
                      'Status',
                      pengajuan.selesai ? 'Selesai' : 'Dalam Proses',
                    ),
                    const SizedBox(height: 18),
                    if (!pengajuan.selesai)
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<PengajuanModel>().tandaiSelesai(id);
                        },
                        icon: const Icon(Icons.task_alt),
                        label: const Text('Tandai Selesai'),
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

class _BarisDetail extends StatelessWidget {
  final String label;
  final String nilai;

  const _BarisDetail(this.label, this.nilai);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted)),
          const SizedBox(height: 4),
          Text(nilai, style: const TextStyle(fontWeight: FontWeight.w700)),
          const Divider(height: 20),
        ],
      ),
    );
  }
}
