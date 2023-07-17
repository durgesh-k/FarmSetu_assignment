import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_weather_app/providers/weather_provider.dart';
import 'package:the_weather_app/utils/constants.dart';
import 'package:the_weather_app/utils/key.dart';

import '../widgets/loader.dart';

class WeatherMap extends StatefulWidget {
  const WeatherMap({super.key});

  @override
  State<WeatherMap> createState() => _WeatherMapState();
}

class _WeatherMapState extends State<WeatherMap> {
  late int zoomLevel = 1;
  late int xCoordinate = 1;
  late int yCoordinate = 1;

  String? zoomType = "Global";

  late GoogleMapController mapController;
  bool isMapScrollable = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
      return weatherProvider.loading
          ? const Center(child: Loader())
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target:
                        LatLng(xCoordinate.toDouble(), yCoordinate.toDouble()),
                    zoom: zoomLevel.toDouble(),
                  ),
                ),
                Positioned.fill(
                  child: Image.network(
                      'https://tile.openweathermap.org/map/temp_new/$zoomLevel/${xCoordinate}/${yCoordinate}.png?appid=${api_key}',
                      fit: BoxFit.cover, loadingBuilder: (BuildContext context,
                          Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null)
                      return child; // Return the image widget when the image is fully loaded.
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }),
                ),
                Positioned.fill(
                  child: Image.network(
                      'https://tile.openweathermap.org/map/precipitation_new/$zoomLevel/${xCoordinate}/${yCoordinate}.png?appid=${api_key}',
                      fit: BoxFit.cover, loadingBuilder: (BuildContext context,
                          Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null)
                      return child; // Return the image widget when the image is fully loaded.
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }),
                ),
                Positioned(
                  top: 18,
                  right: 18,
                  child: InkWell(
                    onTap: () {
                      if (zoomLevel == 1) {
                        setState(() {
                          zoomLevel = 9;
                          xCoordinate =
                              weatherProvider.weatherData.latitude.floor();
                          yCoordinate =
                              weatherProvider.weatherData.longitude.floor();
                          zoomType = "Region";
                        });
                        mapController
                            .animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(weatherProvider.weatherData.latitude,
                                weatherProvider.weatherData.longitude),
                            zoom: zoomLevel.toDouble(),
                          ),
                        ));
                      } else {
                        setState(() {
                          zoomLevel = 1;
                          xCoordinate = 1;
                          yCoordinate = 1;
                          zoomType = "Global";
                        });
                        mapController
                            .animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(
                                xCoordinate.toDouble(), yCoordinate.toDouble()),
                            zoom: zoomLevel.toDouble(),
                          ),
                        ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: grey,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          zoomType!,
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              color: primary,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
    });
  }
}
