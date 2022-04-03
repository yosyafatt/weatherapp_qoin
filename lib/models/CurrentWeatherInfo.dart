class CurrentWeatherInfo {
  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  Current current;

  CurrentWeatherInfo(
      {this.lat, this.lon, this.timezone, this.timezoneOffset, this.current});

  CurrentWeatherInfo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['timezone'] = this.timezone;
    data['timezone_offset'] = this.timezoneOffset;
    if (this.current != null) {
      data['current'] = this.current.toJson();
    }
    return data;
  }
}

class Current {
  num dt;
  num temp;
  num humidity;
  num windSpeed;
  num uvi;
  List<Weather> weather;

  Current(
      {this.dt,
      this.temp,
      this.humidity,
      this.windSpeed,
      this.weather,
      this.uvi});

  Current.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'];
    humidity = json['humidity'];
    windSpeed = json['wind_speed'];
    uvi = json['uvi'];
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['temp'] = this.temp;
    data['humidity'] = this.humidity;
    data['wind_speed'] = this.windSpeed;
    data['uvi'] = this.uvi;
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}
