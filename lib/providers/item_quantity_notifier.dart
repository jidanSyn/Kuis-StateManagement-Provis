import 'package:flutter/foundation.dart';

class ItemQuantityNotifier extends ChangeNotifier {
  Map<int, int> _quantities = {};

  int getQuantity(int itemId) {
    return _quantities[itemId] ?? 0;
  }

  void incrementQuantity(int itemId) {
      print("adding itemid $itemId by 1");
    _quantities.update(itemId, (value) => value + 1, ifAbsent: () => 1);
      print(_quantities);
    notifyListeners();
  }

  void decrementQuantity(int itemId) {
      print("removing itemid $itemId by 1");

    if (_quantities.containsKey(itemId)) {
      if (_quantities[itemId]! > 0) {
        _quantities.update(itemId, (value) => value - 1);
        print(_quantities);
        notifyListeners();
      }
    }
  }
  Map<int, int> getAllItemQuantities() {
    return this._quantities;
  }

  void addItem(int item_id, int quantity) {
    _quantities[item_id] = quantity;
    notifyListeners();
  }

  void removeItem(int item_id) {
    print("before removal");
    print(_quantities);
    _quantities.remove(item_id);
    print("after removal");
    print(_quantities);
    notifyListeners();

  }

  void removeAllQuantities() {
    _quantities.clear();
    notifyListeners();
  }
}
