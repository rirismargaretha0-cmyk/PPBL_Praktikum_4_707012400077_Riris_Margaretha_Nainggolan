import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../model/pengajuan_model.dart';
import '../theme/app_colors.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();
    final bidang = PengajuanModel.bidangTersedia;

    final jumlah = bidang.map(model.jumlahBidang).toList();

    final tertinggi = jumlah.reduce((a, b) => a > b ? a : b);

    final batasAtas = (tertinggi + 2 < 5 ? 5 : tertinggi + 2).toDouble();

    const warnaBatang = [AppColors.primary, AppColors.teal, AppColors.gold];

    const labelPendek = ['Admin', 'Sehat', 'Didik'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Statistik Layanan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              const Text(
                'Perbandingan jumlah pengajuan pada setiap bidang layanan.',
                style: TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  bidang.length,
                  (index) => Chip(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.line),
                    avatar: CircleAvatar(
                      backgroundColor: warnaBatang[index],
                      radius: 8,
                    ),
                    label: Text('${bidang[index]}: ${jumlah[index]}'),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 26, 18, 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.line),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  height: 330,
                  child: BarChart(
                    BarChartData(
                      maxY: batasAtas,
                      alignment: BarChartAlignment.spaceAround,
                      gridData: const FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 38,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();

                              if (index < 0 || index >= labelPendek.length) {
                                return const SizedBox.shrink();
                              }

                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  labelPendek[index],
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.ink,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      barGroups: List.generate(
                        bidang.length,
                        (index) => BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: jumlah[index].toDouble(),
                              color: warnaBatang[index],
                              width: 28,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                model.total == 0
                    ? 'Belum ada data pengajuan. Isi formulir layanan terlebih dahulu.'
                    : 'Total ${model.total} pengajuan, termasuk ${model.jumlahSelesai} pengajuan selesai.',
                style: const TextStyle(color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
