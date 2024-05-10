import 'package:flutter/foundation.dart';

class ItemQuantityNotifier extends ChangeNotifier {
  Map<int, int> _quantities = {};

  int getQuantity(int itemId) {
    return _quantities[itemId] ?? 0;
  }

  void incrementQuantity(int itemId) {
    _quantities.update(itemId, (value) => value + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void decrementQuantity(int itemId) {
    if (_quantities.containsKey(itemId)) {
      if (_quantities[itemId]! > 0) {
        _quantities.update(itemId, (value) => value - 1);
        notifyListeners();
      }
    }
  }
  Map<int, int> getAllItemQuantities() {
    return this._quantities;
  }
}
