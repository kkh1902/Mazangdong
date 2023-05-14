class RegionModel {
  bool? seoulSelected;
  bool? busanSelected;
  bool? incheonSelected;
  bool? daeguSelected;
  bool? daejeonSelected;
  bool? gwangjuSelected;
  bool? ulsanSelected;
  bool? sejongSelected;

  RegionModel({
    this.seoulSelected,
    this.busanSelected,
    this.incheonSelected,
    this.daeguSelected,
    this.daejeonSelected,
    this.gwangjuSelected,
    this.ulsanSelected,
    this.sejongSelected,
  });

  @override
  String toString() {
    return 'Region: {seoulSelected: $seoulSelected, busanSelected: $busanSelected, incheonSelected: $incheonSelected, daeguSelected: $daeguSelected, daejeonSelected: $daejeonSelected, gwangjuSelected: $gwangjuSelected, ulsanSelected: $ulsanSelected, sejongSelected: $sejongSelected}';
  }
}