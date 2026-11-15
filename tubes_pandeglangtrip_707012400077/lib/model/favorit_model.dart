import 'package:flutter/foundation.dart';

class FavoritModel extends ChangeNotifier {
  final Set<String> _favorit = {};

  int get jumlah => _favorit.length;

  bool disukai(String idPaket) {
    return _favorit.contains(idPaket);
  }

  void ubah(String idPaket) {
    if (_favorit.contains(idPaket)) {
      _favorit.remove(idPaket);
    } else {
      _favorit.add(idPaket);
    }

    notifyListeners();
  }
}
