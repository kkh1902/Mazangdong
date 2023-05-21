import 'package:flutter/foundation.dart';

class SelectedModel extends ChangeNotifier {
  List<int> selectedList = [];

  void addItem(int item) {
    selectedList.add(item);
    notifyListeners();
  }

  void removeItem(int item) {
    selectedList.remove(item);
    notifyListeners();
  }

  void clearList() {
    selectedList.clear();
    notifyListeners();
  }
}
