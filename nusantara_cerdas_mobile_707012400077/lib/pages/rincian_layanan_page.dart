import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/form_pengajuan.dart';

class RincianLayananPage extends StatelessWidget {
  const RincianLayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.teal],
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Pengajuan Layanan Publik',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Pilih bidang layanan dan jadwal kunjungan yang sesuai.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: AppColors.line),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(22),
                  child: FormPengajuan(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
