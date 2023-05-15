class ConvModel {
  String? nickname;
  int? isTravelingAlone;
  List<int> selectedOptions;

  @override
  String toString() {
    return 'convenienceModel: {nickname: $nickname, isTravelingAlone: $isTravelingAlone, selectedOptions: $selectedOptions}';
  }

  ConvModel({
    this.nickname,
    this.isTravelingAlone,
    List<int>? selectedOptions,
  }) : selectedOptions = selectedOptions ?? [];

  bool isOptionSelected(int option) {
    return selectedOptions.contains(option);
  }

  void toggleOption(int option) {
    if (isOptionSelected(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
  }
}
