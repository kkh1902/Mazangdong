class ResponseModel {
  final List<TripModel> trip;
  final List<LodgingModel> lodging;

  ResponseModel({
    required this.trip,
    required this.lodging,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      trip: List<TripModel>.from(
        json['trip'].map((trip) => TripModel.fromJson(trip)),
      ),
      lodging: List<LodgingModel>.from(
        json['lodging'].map((lodging) => LodgingModel.fromJson(lodging)),
      ),
    );
  }
  void printData() {
    print('Trip:');
    for (var tripModel in trip) {
      print('관광지번호: ${tripModel.gwangwangjibunho}');
      print('관광지이름: ${tripModel.gwangwangjiyeon}');
      print('분류: ${tripModel.bunryu}');
      print('지역번호: ${tripModel.jiyangbunho}');
      print('주소: ${tripModel.juso}');
      print('문의번호: ${tripModel.muneobunho}');
      print('주차여부: ${tripModel.juchayeobu}');
      print('휠체어대여: ${tripModel.hwichesil}');
      print('엘리베이터: ${tripModel.hwajangsir}');
      print('화장실: ${tripModel.imagegyeongryo}');
      print('위도: ${tripModel.latitude}');
      print('경도: ${tripModel.longitude}');
      print('----------------------------');
    }

    print('Lodging:');
    for (var lodgingModel in lodging) {
      print('숙박시설번호: ${lodgingModel.sungbaksiseolbunho}');
      print('숙박시설이름: ${lodgingModel.sungbaksiseolime}');
      print('지역번호: ${lodgingModel.jiyangbunho}');
      print('숙박시설주소: ${lodgingModel.sungbaksiseoljuso}');
      print('숙박시설전화번호: ${lodgingModel.sungbaksiseoljeonhwanum}');
      print('주차여부: ${lodgingModel.juchayeobu}');
      print('휠체어대여: ${lodgingModel.hwichesil}');
      print('엘리베이터: ${lodgingModel.hwajangsir}');
      print('화장실: ${lodgingModel.imagegyeongryo}');
      print('장애인객실여부: ${lodgingModel.jangaeingaeksilyeobu}');
      print('위도: ${lodgingModel.latitude}');
      print('경도: ${lodgingModel.longitude}');
      print('----------------------------');
    }
  }

}

class TripModel {
  final int gwangwangjibunho;
  final String gwangwangjiyeon;
  final String bunryu;
  final String jiyangbunho;
  final String juso;
  final String muneobunho;
  final String juchayeobu;
  final String hwichesil;
  final String hwajangsir;
  final String imagegyeongryo;
  final double latitude; // 추가된 위도
  final double longitude; // 추가된 경도

  TripModel({
    required this.gwangwangjibunho,
    required this.gwangwangjiyeon,
    required this.bunryu,
    required this.jiyangbunho,
    required this.juso,
    required this.muneobunho,
    required this.juchayeobu,
    required this.hwichesil,
    required this.hwajangsir,
    required this.imagegyeongryo,
    required this.latitude,
    required this.longitude,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      gwangwangjibunho: json['관광지번호'],
      gwangwangjiyeon: json['관광지이름'],
      bunryu: json['분류'],
      jiyangbunho: json['지역번호'],
      juso: json['주소'],
      muneobunho: json['문의번호'],
      juchayeobu: json['주차여부'],
      hwichesil: json['휠체어대여'],
      hwajangsir: json['엘리베이터'],
      imagegyeongryo: json['화장실'],
      latitude: 0.0, // Initialize with default values
      longitude: 0.0, // Initialize with default values
    );
  }
}

class LodgingModel {
  final int sungbaksiseolbunho;
  final String sungbaksiseolime;
  final String jiyangbunho;
  final String sungbaksiseoljuso;
  final String sungbaksiseoljeonhwanum;
  final String juchayeobu;
  final String hwichesil;
  final String hwajangsir;
  final String imagegyeongryo;
  final String jangaeingaeksilyeobu;
  final double? latitude; // 추가된 위도
  final double? longitude; // 추가된 경도

  LodgingModel({
    required this.sungbaksiseolbunho,
    required this.sungbaksiseolime,
    required this.jiyangbunho,
    required this.sungbaksiseoljuso,
    required this.sungbaksiseoljeonhwanum,
    required this.juchayeobu,
    required this.hwichesil,
    required this.hwajangsir,
    required this.imagegyeongryo,
    required this.jangaeingaeksilyeobu,
    required this.latitude,
    required this.longitude,
  });

  factory LodgingModel.fromJson(Map<String, dynamic> json) {
    return LodgingModel(
      sungbaksiseolbunho: json['숙박시설번호'],
      sungbaksiseolime: json['숙박시설이름'],
      jiyangbunho: json['지역번호'],
      sungbaksiseoljuso: json['숙박시설주소'],
      sungbaksiseoljeonhwanum: json['숙박시설전화번호'],
      juchayeobu: json['주차여부'],
      hwichesil: json['휠체어대여'],
      hwajangsir: json['엘리베이터'],
      imagegyeongryo: json['화장실'],
      jangaeingaeksilyeobu: json['장애인객실여부'],
      latitude: 0.0, // Initialize with default values
      longitude: 0.0, // Initialize with default values
    );
  }
}
