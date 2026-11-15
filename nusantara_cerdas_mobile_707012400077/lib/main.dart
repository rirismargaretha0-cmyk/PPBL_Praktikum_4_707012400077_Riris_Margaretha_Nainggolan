import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/pengajuan_model.dart';
import 'navigation/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PengajuanModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nusantara Cerdas Mobile',
        theme: AppTheme.light,
        initialRoute: AppRoutes.beranda,
        routes: AppRoutes.daftarRoute(),
        onGenerateRoute: AppRoutes.bentukRoute,
        onUnknownRoute: AppRoutes.routeTidakDikenal,
      ),
    ),
  );
}
