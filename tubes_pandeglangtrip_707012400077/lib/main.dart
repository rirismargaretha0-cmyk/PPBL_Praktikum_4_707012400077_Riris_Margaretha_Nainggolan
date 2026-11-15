import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/favorit_model.dart';
import 'model/pemesanan_model.dart';
import 'navigation/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritModel()),
        ChangeNotifierProvider(create: (_) => PemesananModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PandeglangTrip',
        theme: AppTheme.light,
        initialRoute: AppRoutes.beranda,
        routes: AppRoutes.daftarRoute(),
        onGenerateRoute: AppRoutes.bentukRoute,
        onUnknownRoute: AppRoutes.routeTidakDikenal,
      ),
    ),
  );
}
