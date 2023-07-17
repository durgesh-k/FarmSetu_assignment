class WeatherData {
  final double latitude;
  final double longitude;
  final String main;
  final String description;
  final String icon;
  final int visibility;
  final double wind;
  final int clouds;
  final double temperature;
  final double feelsLike;
  final double minTemperature;
  final double maxTemperature;
  final int pressure;
  final int humidity;
  final int seaLevel;
  //final double rain;
  final String country;
  final int timezone;
  final int id;
  final String name;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.main,
    required this.description,
    required this.icon,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.temperature,
    required this.feelsLike,
    required this.minTemperature,
    required this.maxTemperature,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    //required this.rain,
    required this.country,
    required this.timezone,
    required this.id,
    required this.name,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: json['coord']['lat'],
      longitude: json['coord']['lon'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      visibility: json['visibility'],
      wind: json['wind']['speed'],
      clouds: json['clouds']['all'],
      temperature: json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      maxTemperature: json['main']['temp_max'],
      minTemperature: json['main']['temp_min'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      seaLevel: json['main']['sea_level'],
      //rain: json['rain']['1h'] ?? 0.0,
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      country: json['sys']['country'],
    );
  }
}
