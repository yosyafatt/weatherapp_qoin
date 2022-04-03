class DailyWeatherInfo {
  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  List<Daily> daily;

  DailyWeatherInfo(
      {this.lat, this.lon, this.timezone, this.timezoneOffset, this.daily});

  DailyWeatherInfo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    if (json['daily'] != null) {
      daily = new List<Daily>();
      json['daily'].forEach((v) {
        daily.add(new Daily.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['timezone'] = this.timezone;
    data['timezone_offset'] = this.timezoneOffset;
    if (this.daily != null) {
      data['daily'] = this.daily.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Daily {
  int dt;
  Temp temp;
  FeelsLike feelsLike;
  num humidity;
  num windSpeed;
  List<Weather> weather;
  num pop;

  Daily({
    this.dt,
    this.temp,
    this.feelsLike,
    this.humidity,
    this.windSpeed,
    this.weather,
    this.pop,
  });

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'] != null ? new Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null
        ? new FeelsLike.fromJson(json['feels_like'])
        : null;
    humidity = json['humidity'];
    windSpeed = json['wind_speed'];
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    pop = json['pop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    if (this.temp != null) {
      data['temp'] = this.temp.toJson();
    }
    if (this.feelsLike != null) {
      data['feels_like'] = this.feelsLike.toJson();
    }
    data['humidity'] = this.humidity;
    data['wind_speed'] = this.windSpeed;
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    data['pop'] = this.pop;
    return data;
  }
}

class Temp {
  num day;
  num night;

  Temp({
    this.day,
    this.night,
  });

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    night = json['night'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['night'] = this.night;
    return data;
  }
}

class FeelsLike {
  num day;
  num night;

  FeelsLike({
    this.day,
    this.night,
  });

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    night = json['night'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['night'] = this.night;
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
