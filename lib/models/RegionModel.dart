class RegionModel {
  List<int> selectedRegions;

  RegionModel({
    List<int>? selectedRegions,
  }) : selectedRegions = selectedRegions ?? [];

  @override
  String toString() {
    return 'RegionModel: {selectedRegions: $selectedRegions}';
  }

  bool isRegionSelected(int region) {
    return selectedRegions.contains(region);
  }

  void toggleRegion(int region) {
    if (isRegionSelected(region)) {
      selectedRegions.remove(region);
    } else {
      selectedRegions.add(region);
    }
  }
}
