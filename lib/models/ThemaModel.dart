class ThemaModel {
  List<int> selectedCategories;

  ThemaModel({
    List<int>? selectedCategories,
  }) : selectedCategories = selectedCategories ?? [];

  @override
  String toString() {
    return 'ThemaModel: {selectedCategories: $selectedCategories}';
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
  }
}
