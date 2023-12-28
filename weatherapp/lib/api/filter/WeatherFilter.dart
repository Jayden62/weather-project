class WeatherFilter {
  double? lat;
  double? lon;
  String? lang;
  String? appid;
  String? units;
  String? q;

  WeatherFilter({this.lat, this.lon, this.appid, this.units,this.q});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['appid'] = this.appid;
    data['lang'] = this.lang;
    data['units'] = this.units;
    data['q'] = this.q;
    return data;
  }
}
