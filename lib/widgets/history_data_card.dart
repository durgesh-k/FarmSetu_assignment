import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_weather_app/providers/weather_provider.dart';
import 'package:the_weather_app/utils/constants.dart';
import 'package:the_weather_app/utils/converters.dart';
import 'package:the_weather_app/utils/toast.dart';

class HistoricalDataCard extends StatelessWidget {
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

  const HistoricalDataCard({
    super.key,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 2,
            width: getWidth(context),
            color: grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 50),
            child: Consumer<WeatherProvider>(
                builder: (context, weatherProvider, child) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            weatherProvider.weatherData.name,
                            style: TextStyle(
                                fontFamily: 'Medium',
                                color: black?.withOpacity(0.2),
                                fontSize: 18),
                          ),
                          Text(
                            formatDate(localTimestamp),
                            style: TextStyle(
                                fontFamily: 'SemiBold',
                                color: black?.withOpacity(0.5),
                                fontSize: 16),
                          ),
                          Text(
                            formatTime(localTimestamp),
                            style: TextStyle(
                                fontFamily: 'SemiBold',
                                color: black,
                                fontSize: 30),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            weatherCondition,
                            style: TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 20,
                                color: black?.withOpacity(0.3)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${temperature.toString()}°",
                                style: TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 26,
                                    color: black),
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.network(
                                  "https://www.weatherbit.io/static/img/icons/$icon.png",
                                  fit: BoxFit.contain,
                                  color: primary,
                                  errorBuilder: (context, error, stackTrace) {
                                    showToast('Error loading icon');
                                    return const Icon(
                                      Icons.error_outline_rounded,
                                      color: Colors.red,
                                      size: 20,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Table(
                      defaultColumnWidth: const IntrinsicColumnWidth(),
                      children: [
                        TableRow(
                          children: [
                            Text(
                              'humidity ',
                              style: TextStyle(
                                  fontFamily: 'Medium',
                                  color: black?.withOpacity(0.2),
                                  fontSize: 16),
                            ),
                            Text(
                              "${relativeHumidity}%",
                              style: TextStyle(
                                  fontFamily: 'Medium',
                                  color: black,
                                  fontSize: 16),
                            ),
                            Text(
                              'wind ',
                              style: TextStyle(
                                  fontFamily: 'Medium',
                                  color: black?.withOpacity(0.2),
                                  fontSize: 16),
                            ),
                            Text(
                              "${windSpeed} m/s",
                              style: TextStyle(
                                  fontFamily: 'Medium',
                                  color: black,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(
                              'pressure ',
                              style: TextStyle(
                                  fontFamily: 'Medium',
                                  color: black?.withOpacity(0.2),
                                  fontSize: 16),
                            ),
                            Text(
                              "${pressure} hPa",
                              style: TextStyle(
                                  fontFamily: 'Medium',
                                  color: black,
                                  fontSize: 16),
                            ),
                            Text(
                              'sea level ',
                              style: TextStyle(
                                  fontFamily: 'Medium',
                                  color: black?.withOpacity(0.2),
                                  fontSize: 16),
                            ),
                            Text(
                              "${seaLevelPressure} hPa",
                              style: TextStyle(
                                  fontFamily: 'Medium',
                                  color: black,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
