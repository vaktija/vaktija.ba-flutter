class VaktijaSettingsModel {
  //List<VakatSettingsModel> vaktovi;
  int? currentCity;
  int? currentCountry;
  bool? dzumaSpecial;

  // bool? zuhrTimeFixed;
  bool? vakatFieldHint;
  bool? permanentVaktija;
  bool? permanentVaktijaDailyVakats;

  VaktijaSettingsModel({
    //required this.vaktovi,
    this.currentCity = 77,
    this.currentCountry = 9,
    this.dzumaSpecial = false,
    // this.zuhrTimeFixed = true,
    this.vakatFieldHint = true,
    this.permanentVaktija = false,
    this.permanentVaktijaDailyVakats = true
  });

  factory VaktijaSettingsModel.fromJson(Map<String, dynamic> json) {
    return VaktijaSettingsModel(
      currentCity: json['currentCity'] ?? 77,
      currentCountry: json['currentCountry'] ?? 9,
      dzumaSpecial: json['dzumaSpecial'] ?? false,
      vakatFieldHint: json['vakatFieldHint'] ?? true,
      permanentVaktija: json['permanentVaktija'] ?? false,
      permanentVaktijaDailyVakats: json['permanentVaktijaDailyVakats'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentCity': currentCity,
      'currentCountry': currentCountry,
      'dzumaSpecial': dzumaSpecial,
      'vakatFieldHint': vakatFieldHint,
      'permanentVaktija': permanentVaktija,
      'permanentVaktijaDailyVakats': permanentVaktijaDailyVakats
    };
  }
}
