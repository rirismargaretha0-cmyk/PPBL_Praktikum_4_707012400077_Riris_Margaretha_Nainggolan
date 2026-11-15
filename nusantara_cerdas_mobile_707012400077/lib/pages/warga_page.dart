import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';
import '../theme/app_colors.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();
    final daftar = model.semua;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      Color(0xFF146F9C),
                      AppColors.teal,
                    ],
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NUSANTARA CERDAS MOBILE',
                            style: TextStyle(
                              color: Color(0xFFDCEEFF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Layanan Warga Lebih Mudah',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Ajukan layanan, pantau proses, dan temukan kantor layanan.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(
                      Icons.apartment_rounded,
                      size: 56,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ringkasan Pengajuan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _KartuRingkas(
                    label: 'Total Pengajuan',
                    nilai: model.total,
                    icon: Icons.folder_open_outlined,
                    warna: AppColors.primary,
                  ),
                  _KartuRingkas(
                    label: 'Dalam Proses',
                    nilai: model.jumlahDiproses,
                    icon: Icons.hourglass_bottom,
                    warna: AppColors.gold,
                  ),
                  _KartuRingkas(
                    label: 'Selesai',
                    nilai: model.jumlahSelesai,
                    icon: Icons.task_alt,
                    warna: AppColors.success,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Bidang Layanan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: PengajuanModel.bidangTersedia
                    .map(
                      (bidang) => Chip(
                        avatar: const Icon(
                          Icons.verified_user_outlined,
                          size: 18,
                        ),
                        label: Text(bidang),
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: AppColors.line),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              const Text(
                'Riwayat Pengajuan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              const Text(
                'Ketuk kartu untuk detail dan tahan untuk menandai selesai.',
                style: TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 12),
              if (daftar.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.line),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 44,
                        color: AppColors.muted,
                      ),
                      SizedBox(height: 10),
                      Text('Belum ada pengajuan'),
                      SizedBox(height: 5),
                      Text(
                        'Gunakan tombol Pengajuan Baru untuk memulai.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.muted),
                      ),
                    ],
                  ),
                )
              else
                ...daftar.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.detailPengajuan,
                          arguments: item.id,
                        );
                      },
                      onLongPress: () {
                        final berhasil = context
                            .read<PengajuanModel>()
                            .tandaiSelesai(item.id);

                        if (berhasil) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pengajuan ditandai selesai.'),
                            ),
                          );
                        }
                      },
                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: AppColors.line),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Color(0xFFE7F0FF),
                                child: Icon(
                                  Icons.description_outlined,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.bidang,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${item.nama} • Sesi ${item.sesi}',
                                      style: const TextStyle(
                                        color: AppColors.muted,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item.selesai ? 'Selesai' : 'Diproses',
                                style: TextStyle(
                                  color: item.selesai
                                      ? AppColors.success
                                      : AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}

class _KartuRingkas extends StatelessWidget {
  final String label;
  final int nilai;
  final IconData icon;
  final Color warna;

  const _KartuRingkas({
    required this.label,
    required this.nilai,
    required this.icon,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: warna),
          const SizedBox(height: 11),
          Text(
            '$nilai',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
          Text(label, style: const TextStyle(color: AppColors.muted)),
        ],
      ),
    );
  }
}
