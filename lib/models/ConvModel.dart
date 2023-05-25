class ConvModel {
  String? nickname;
  int? isTravelingAlone;
  int? isTransportation;
  int? isBus;
  List<int> selectedOptions;
  List<int> selectedRegions;

  @override
  String toString() {
    return 'ConvModel: {nickname: $nickname, isTravelingAlone: $isTravelingAlone, isTransportation: $isTransportation, isBus: $isBus, selectedOptions: $selectedOptions, selectedRegions: $selectedRegions}';
  }

  ConvModel({
    this.nickname,
    this.isTravelingAlone,
    this.isTransportation,
    this.isBus,
    List<int>? selectedOptions,
    List<int>? selectedRegions,
  })  : selectedOptions = selectedOptions ?? [],
        selectedRegions = selectedRegions ?? [];

  bool isOptionSelected(int option) {
    return selectedOptions.contains(option);
  }

  bool isRegionSelected(int region) {
    return selectedRegions.contains(region);
  }

  void toggleOption(int option) {
    if (isOptionSelected(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
  }

  void toggleRegion(int region) {
    if (isRegionSelected(region)) {
      selectedRegions.remove(region);
    } else {
      selectedRegions.add(region);
    }
  }
}
