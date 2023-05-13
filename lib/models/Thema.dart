class CategoryModel {
  bool? naturalScenerySelected;
  bool? trekkingSelected;
  bool? beachSelected;
  bool? localSightseeingSelected;
  bool? culturalArtSelected;
  bool? shoppingSelected;

  CategoryModel({
    this.naturalScenerySelected,
    this.trekkingSelected,
    this.beachSelected,
    this.localSightseeingSelected,
    this.culturalArtSelected,
    this.shoppingSelected,
  });

  @override
  String toString() {
    return 'Category: {naturalScenerySelected: $naturalScenerySelected, trekkingSelected: $trekkingSelected, beachSelected: $beachSelected, localSightseeingSelected: $localSightseeingSelected, culturalArtSelected: $culturalArtSelected, shoppingSelected: $shoppingSelected}';
  }
}