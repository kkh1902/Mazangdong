class ThemaModel {
  List<int> selectedCategories;
  int? isCarhave;

  ThemaModel({
    List<int>? selectedCategories,
    this.isCarhave,
  }) : selectedCategories = selectedCategories ?? [];

  @override
  String toString() {
    return 'ThemaModel: {selectedCategories: $selectedCategories, isCarhave: $isCarhave}';
  }

  bool isCategorySelected(int category) {
    return selectedCategories.contains(category);
  }

  void toggleCategory(int category) {
    if (isCategorySelected(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    isCarhave = selectedCategories.isNotEmpty ? 1 : 0;
  }
}
