class ConvModel {
  String? nickname;
  bool? isTravelingAlone;
  bool? parkingSelected;
  bool? wheelchairRentalSelected;
  bool? accessibleRestroomSelected;
  bool? unauthorizedParkingSelected;
  bool? elevatorSelected;

  @override
  String toString() {
    return 'conveninceModel: {nickname: $nickname, isTravelingAlone: $isTravelingAlone, '
        'parkingSelected: $parkingSelected, wheelchairRentalSelected: $wheelchairRentalSelected, '
        'accessibleRestroomSelected: $accessibleRestroomSelected, '
        'unauthorizedParkingSelected: $unauthorizedParkingSelected, '
        'elevatorSelected: $elevatorSelected}';
  }

  ConvModel({
    this.nickname,
    this.isTravelingAlone,
    this.parkingSelected,
    this.wheelchairRentalSelected,
    this.accessibleRestroomSelected,
    this.unauthorizedParkingSelected,
    this.elevatorSelected,
  });
}
