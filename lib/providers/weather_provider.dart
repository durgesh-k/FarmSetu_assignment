import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:the_weather_app/utils/key.dart';
import 'package:the_weather_app/utils/toast.dart';
import '../models/weather_data.dart';

class WeatherProvider extends ChangeNotifier {
  Position? _position;
  WeatherData? _weatherData;
  bool loading = true;
  bool error = false;

  Position get position => _position!;
  WeatherData get weatherData => _weatherData!;

  WeatherProvider() {
    getCurrentLocation();
  }

  Future<void> _fetchWeatherData(Position location) async {
    try {
      final url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=${api_key}");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        _weatherData = WeatherData.fromJson(jsonData);
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
      showToast("There was some error loading weather data");
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
      _fetchWeatherData(_position!);
      notifyListeners();
    } catch (e) {
      error = true;
      loading = false;
      showToast('Error fetching location');
      notifyListeners();
    }
  }
}
