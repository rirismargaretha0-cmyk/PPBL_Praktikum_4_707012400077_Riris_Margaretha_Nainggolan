import 'package:flutter/material.dart';

import '../pages/eksplorasi_page.dart';
import '../pages/paket_tur_page.dart';
import '../pages/tiket_saya_page.dart';
import '../theme/app_theme.dart';

class KerangkaNavigasi extends StatefulWidget {
  final int indeksAwal;

  const KerangkaNavigasi({super.key, this.indeksAwal = 0});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  late int _indeks;

  final List<Widget> _halaman = const [
    EksplorasiPage(),
    PaketTurPage(),
    TiketSayaPage(),
  ];

  final List<String> _judul = const [
    'Eksplorasi PandeglangTrip',
    'Paket Tur',
    'Tiket Saya',
  ];

  @override
  void initState() {
    super.initState();
    _indeks = widget.indeksAwal;
  }

  void _pilih(int indeks) {
    setState(() {
      _indeks = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.sizeOf(context).width;

    final layarLebar = lebar >= 800;

    return Scaffold(
      appBar: AppBar(title: Text(_judul[_indeks])),
      body: layarLebar
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _indeks,
                  onDestinationSelected: _pilih,
                  extended: lebar >= 1100,
                  backgroundColor: Colors.white,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore),
                      label: Text('Eksplorasi'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.confirmation_number_outlined),
                      selectedIcon: Icon(Icons.confirmation_number),
                      label: Text('Paket Tur'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.receipt_long_outlined),
                      selectedIcon: Icon(Icons.receipt_long),
                      label: Text('Tiket Saya'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: IndexedStack(index: _indeks, children: _halaman),
                ),
              ],
            )
          : IndexedStack(index: _indeks, children: _halaman),
      bottomNavigationBar: layarLebar
          ? null
          : NavigationBar(
              selectedIndex: _indeks,
              onDestinationSelected: _pilih,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore, color: AppColors.primary),
                  label: 'Eksplorasi',
                ),
                NavigationDestination(
                  icon: Icon(Icons.confirmation_number_outlined),
                  selectedIcon: Icon(Icons.confirmation_number),
                  label: 'Paket Tur',
                ),
                NavigationDestination(
                  icon: Icon(Icons.receipt_long_outlined),
                  selectedIcon: Icon(Icons.receipt_long),
                  label: 'Tiket Saya',
                ),
              ],
            ),
    );
  }
}
