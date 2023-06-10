class BarrierData {
  String type;
  String address;
  double latitude;
  double longitude;
  bool bypass;
  String nickname;
  String photo;
  String detailedAddress;

  BarrierData({
    this.type = '',
    this.address = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.bypass = false,
    this.nickname = '',
    this.photo = '',
    this.detailedAddress = '',
  });

  factory BarrierData.fromJson(Map<String, dynamic> json) {
    return BarrierData(
      type: json['type'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      bypass: json['bypass'],
      nickname: json['nickname'],
      photo: json['photo'],
      detailedAddress: json['detailedAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'bypass': bypass,
      'nickname': nickname,
      'photo': photo,
      'detailedAddress': detailedAddress,
    };
  }

  void printData() {
    print('BarrierData:');
    print('  type: $type');
    print('  address: $address');
    print('  latitude: $latitude');
    print('  longitude: $longitude');
    print('  bypass: $bypass');
    print('  nickname: $nickname');
    print('  photo: $photo');
    print('  detailedAddress: $detailedAddress');
  }




}
