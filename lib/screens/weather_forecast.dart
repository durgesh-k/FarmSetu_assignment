import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_weather_app/providers/weather_provider.dart';
import 'package:the_weather_app/utils/constants.dart';
import 'package:the_weather_app/utils/converters.dart';
import 'package:the_weather_app/widgets/loader.dart';
import 'package:the_weather_app/widgets/error.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
      return SizedBox(
        height: getHeight(context),
        width: getWidth(context),
        child: weatherProvider.loading
            ? const Center(child: Loader())
            : weatherProvider.error
                ? const Center(child: Error())
                : Column(
                    children: [
                      Container(
                        height: 2,
                        width: getWidth(context),
                        color: grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: getHeight(context) * 0.02,
                            ),
                            Text(
                              "${weatherProvider.weatherData.name}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'SemiBold',
                                  color: primary),
                            ),
                            SizedBox(
                              height: getHeight(context) * 0.02,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${kelvinToCelsius(weatherProvider.weatherData.temperature).truncate().toInt()}",
                                      style: TextStyle(
                                          fontSize: 180,
                                          fontFamily: 'Medium',
                                          color: black?.withOpacity(0.8)),
                                    ),
                                    Text(
                                      "°",
                                      style: TextStyle(
                                          fontSize: 60,
                                          fontFamily: 'Medium',
                                          color: black?.withOpacity(0.1)),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Image.network(
                                        "http://openweathermap.org/img/wn/${weatherProvider.weatherData.icon}.png",
                                        fit: BoxFit.contain,
                                        color: primary,
                                      ),
                                    ),
                                    Text(
                                      weatherProvider.weatherData.main,
                                      style: TextStyle(
                                          fontSize: 60,
                                          fontFamily: 'Medium',
                                          color: black?.withOpacity(0.1)),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "feels like",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'SemiBold',
                                              color: black),
                                        ),
                                        Text(
                                          " ${kelvinToCelsius(weatherProvider.weatherData.feelsLike).truncate().toString()}°",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'SemiBold',
                                              color: black?.withOpacity(0.3)),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: getHeight(context) * 0.03),
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: grey,
                            ),
                            SizedBox(height: getHeight(context) * 0.03),
                            /*Row(
                          children: [
                            Text(
                              'Other data   ',
                              style: TextStyle(
                                  fontFamily: 'SemiBold',
                                  color: black,
                                  fontSize: 20),
                            ),
                            Flexible(
                              child: Container(
                                height: 2,
                                width: double.infinity,
                                color: grey,
                              ),
                            ),
                          ],
                        ),*/
                            SizedBox(
                              width: double.infinity,
                              child: Table(
                                defaultColumnWidth:
                                    const IntrinsicColumnWidth(),
                                children: [
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 28.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.arrow_upward_rounded,
                                              color: primary,
                                            ),
                                            Text(
                                              ' ${kelvinToCelsius(weatherProvider.weatherData.maxTemperature).truncate()}° ',
                                              style: TextStyle(
                                                  fontFamily: 'Medium',
                                                  color: black,
                                                  fontSize: 34),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        " ",
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 28.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.arrow_downward_rounded,
                                              color: primary,
                                            ),
                                            Text(
                                              ' ${kelvinToCelsius(weatherProvider.weatherData.minTemperature).truncate()}° ',
                                              style: TextStyle(
                                                  fontFamily: 'Medium',
                                                  color: black,
                                                  fontSize: 34),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        " ",
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 28.0),
                                        child: Text(
                                          'humidity ',
                                          style: TextStyle(
                                              fontFamily: 'SemiBold',
                                              color: black?.withOpacity(0.2),
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 28.0),
                                        child: Text(
                                          "${weatherProvider.weatherData.humidity.toString()}%",
                                          style: TextStyle(
                                              fontFamily: 'SemiBold',
                                              color: black,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 28.0),
                                        child: Text(
                                          'wind ',
                                          style: TextStyle(
                                              fontFamily: 'SemiBold',
                                              color: black?.withOpacity(0.2),
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 28.0),
                                        child: Text(
                                          "${weatherProvider.weatherData.wind.toString()} m/s",
                                          style: TextStyle(
                                              fontFamily: 'SemiBold',
                                              color: black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 28.0),
                                        child: Text(
                                          'pressure ',
                                          style: TextStyle(
                                              fontFamily: 'SemiBold',
                                              color: black?.withOpacity(0.2),
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 28.0),
                                        child: Text(
                                          "${weatherProvider.weatherData.pressure.toString()} hPa",
                                          style: TextStyle(
                                              fontFamily: 'SemiBold',
                                              color: black,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 28.0),
                                        child: Text(
                                          'sea level ',
                                          style: TextStyle(
                                              fontFamily: 'SemiBold',
                                              color: black?.withOpacity(0.2),
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 28.0),
                                        child: Text(
                                          "${weatherProvider.weatherData.seaLevel.toString()} hPa",
                                          style: TextStyle(
                                              fontFamily: 'SemiBold',
                                              color: black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      );
    });
  }
}
