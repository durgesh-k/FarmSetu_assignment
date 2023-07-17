class HistoricalWeatherData {
  final double appTemperature;
  final double azimuth;
  final int clouds;
  final double dewpoint;
  final double precipitationRate;
  final int pressure;
  final int relativeHumidity;
  final int seaLevelPressure;
  final double temperature;
  final String localTimestamp;
  final double uvIndex;
  final double visibility;
  final String weatherCondition;
  final String icon;
  final double windSpeed;

  HistoricalWeatherData({
    required this.appTemperature,
    required this.azimuth,
    required this.clouds,
    required this.dewpoint,
    required this.precipitationRate,
    required this.pressure,
    required this.relativeHumidity,
    required this.seaLevelPressure,
    required this.temperature,
    required this.localTimestamp,
    required this.uvIndex,
    required this.visibility,
    required this.weatherCondition,
    required this.icon,
    required this.windSpeed,
  });

  factory HistoricalWeatherData.fromJson(Map<String, dynamic> json) {
    return HistoricalWeatherData(
      appTemperature: json['app_temp'].toDouble(),
      azimuth: json['azimuth'].toDouble(),
      clouds: json['clouds'],
      dewpoint: json['dewpt'].toDouble(),
      precipitationRate: json['precip_rate'].toDouble(),
      pressure: json['pres'],
      relativeHumidity: json['rh'],
      seaLevelPressure: json['slp'],
      temperature: json['temp'].toDouble(),
      localTimestamp: json['timestamp_local'],
      uvIndex: json['uv'].toDouble(),
      visibility: json['vis'].toDouble(),
      weatherCondition: json['weather']['description'],
      icon: json['weather']['icon'],
      windSpeed: json['wind_spd'].toDouble(),
    );
  }
}
