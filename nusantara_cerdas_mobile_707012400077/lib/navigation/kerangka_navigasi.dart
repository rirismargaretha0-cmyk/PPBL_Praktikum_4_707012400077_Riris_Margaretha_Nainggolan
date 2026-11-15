import 'package:flutter/material.dart';

import '../pages/warga_page.dart';
import '../pages/rincian_layanan_page.dart';
import '../pages/chat_page.dart';
import '../pages/peta_page.dart';
import '../pages/statistik_page.dart';
import '../theme/app_colors.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  final int indeksAwal;

  const KerangkaNavigasi({super.key, this.indeksAwal = 0});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  late int _indeksTerpilih;
  late final Set<int> _pernahDibuka;

  final List<Widget> _halaman = const [
    WargaPage(),
    RincianLayananPage(),
    ChatPage(),
    PetaPage(),
    StatistikPage(),
  ];

  static const List<String> _judul = [
    'Beranda Warga',
    'Rincian Layanan',
    'Tanya Petugas',
    'Lokasi Kantor',
    'Statistik Layanan',
  ];

  @override
  void initState() {
    super.initState();
    _indeksTerpilih = widget.indeksAwal;
    _pernahDibuka = {widget.indeksAwal};
  }

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
      _pernahDibuka.add(indeks);
    });
  }

  Widget _isiHalaman() {
    return IndexedStack(
      index: _indeksTerpilih,
      children: List.generate(
        _halaman.length,
        (index) => _pernahDibuka.contains(index)
            ? _halaman[index]
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.sizeOf(context).width;
    final layarLebar = lebar >= 760;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.hub_outlined, color: AppColors.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _judul[_indeksTerpilih],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
      body: layarLebar
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _indeksTerpilih,
                  onDestinationSelected: _pilihTujuan,
                  extended: lebar >= 1100,
                  backgroundColor: Colors.white,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Warga'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.description_outlined),
                      selectedIcon: Icon(Icons.description),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.chat_bubble_outline),
                      selectedIcon: Icon(Icons.chat_bubble),
                      label: Text('Chat'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.location_on_outlined),
                      selectedIcon: Icon(Icons.location_on),
                      label: Text('Kantor'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bar_chart_outlined),
                      selectedIcon: Icon(Icons.bar_chart),
                      label: Text('Statistik'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: _isiHalaman()),
              ],
            )
          : _isiHalaman(),
      bottomNavigationBar: layarLebar
          ? null
          : NavigationBar(
              selectedIndex: _indeksTerpilih,
              onDestinationSelected: _pilihTujuan,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Warga',
                ),
                NavigationDestination(
                  icon: Icon(Icons.description_outlined),
                  selectedIcon: Icon(Icons.description),
                  label: 'Layanan',
                ),
                NavigationDestination(
                  icon: Icon(Icons.chat_bubble_outline),
                  selectedIcon: Icon(Icons.chat_bubble),
                  label: 'Chat',
                ),
                NavigationDestination(
                  icon: Icon(Icons.location_on_outlined),
                  selectedIcon: Icon(Icons.location_on),
                  label: 'Kantor',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart),
                  label: 'Statistik',
                ),
              ],
            ),
      floatingActionButton: _indeksTerpilih == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.pengajuanBaru);
              },
              icon: const Icon(Icons.add),
              label: const Text('Pengajuan Baru'),
            )
          : null,
    );
  }
}
