class TravelPlanModel {
  String? nickname;
  bool? isTravelingAlone;
  bool? parkingSelected;
  bool? wheelchairRentalSelected;
  bool? accessibleRestroomSelected;
  bool? unauthorizedParkingSelected;
  bool? elevatorSelected;

  @override
  String toString() {
    return 'Travel Plan: {nickname: $nickname, isTravelingAlone: $isTravelingAlone, '
        'parkingSelected: $parkingSelected, wheelchairRentalSelected: $wheelchairRentalSelected, '
        'accessibleRestroomSelected: $accessibleRestroomSelected, '
        'unauthorizedParkingSelected: $unauthorizedParkingSelected, '
        'elevatorSelected: $elevatorSelected}';
  }

  TravelPlanModel({
    this.nickname,
    this.isTravelingAlone,
    this.parkingSelected,
    this.wheelchairRentalSelected,
    this.accessibleRestroomSelected,
    this.unauthorizedParkingSelected,
    this.elevatorSelected,
  });
}
