import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:the_weather_app/models/historical_weather.dart';
import 'package:http/http.dart' as http;
import 'package:the_weather_app/utils/key.dart';
import 'package:the_weather_app/utils/toast.dart';

class HistoricalWeatherProvider extends ChangeNotifier {
  List<HistoricalWeatherData> _historicalData = [];
  Position? _position;
  bool loading = true;
  bool error = false;

  List<HistoricalWeatherData> get historicalData => _historicalData;
  Position get position => _position!;

  String formattedStartDate = DateTime.now().toIso8601String().split('T')[0];
  String formattedEndDate = DateTime.now()
      .add(const Duration(days: 1))
      .toIso8601String()
      .split('T')[0];

  HistoricalWeatherProvider() {
    getCurrentLocation();
  }

  Future<void> _fetchHistoricalWeatherData(Position location) async {
    try {
      final url = Uri.parse(
          "https://api.weatherbit.io/v2.0/history/subhourly?lat=${location.latitude}&lon=${location.longitude}&start_date=$formattedStartDate&end_date=$formattedEndDate&key=${api_key_2}");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final hourlyData = jsonData['data'] as List<dynamic>;
        _historicalData = hourlyData
            .map((item) => HistoricalWeatherData(
                  appTemperature: (item['app_temp'] ?? 0).toDouble(),
                  azimuth: (item['azimuth'] ?? 0).toDouble(),
                  clouds: item['clouds'] ?? 0,
                  dewpoint: (item['dewpt'] ?? 0).toDouble(),
                  precipitationRate: (item['precip_rate'] ?? 0).toDouble(),
                  pressure: item['pres'] ?? 0,
                  relativeHumidity: item['rh'] ?? 0,
                  seaLevelPressure: item['slp'] ?? 0,
                  temperature: (item['temp'] ?? 0).toDouble(),
                  localTimestamp: item['timestamp_local'] ?? ' ',
                  uvIndex: (item['uv'] ?? 0).toDouble(),
                  visibility: (item['vis'] ?? 0).toDouble(),
                  weatherCondition: item['weather']['description'] ?? " ",
                  icon: item['weather']['icon'] ?? " ",
                  windSpeed: (item['wind_spd'] ?? 0).toDouble(),
                ))
            .toList();
        _historicalData = _historicalData.reversed.toList();
        _historicalData.removeAt(0);
        loading = false;
        notifyListeners();
      } else {
        loading = false;
        notifyListeners();
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      error = true;
      loading = false;
      notifyListeners();
      showToast("There was some error loading historical data");
    }
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      showToast('Location services are disabled');
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied
      showToast('Location permissions are permanently denied');
      throw 'Location permissions are permanently denied.';
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Location permissions are denied
        showToast('Location permissions are denied');
        throw 'Location permissions are denied.';
      }
    }

    try {
      _position = await Geolocator.getCurrentPosition();
      _fetchHistoricalWeatherData(_position!);
      notifyListeners();
    } catch (e) {
      error = true;
      loading = false;
      showToast('Error fetching location');
      notifyListeners();
    }
  }
}
