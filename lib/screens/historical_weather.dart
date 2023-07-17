import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_weather_app/providers/historical_weather_provider.dart';
import 'package:the_weather_app/utils/constants.dart';
import 'package:the_weather_app/widgets/error.dart';
import 'package:the_weather_app/widgets/history_data_card.dart';
import 'package:the_weather_app/widgets/loader.dart';

class HistoricalWeather extends StatefulWidget {
  const HistoricalWeather({super.key});

  @override
  State<HistoricalWeather> createState() => _HistoricalWeatherState();
}

class _HistoricalWeatherState extends State<HistoricalWeather> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HistoricalWeatherProvider>(
        builder: (context, historicalWeatherProvider, child) {
      return SizedBox(
        height: getHeight(context),
        width: getWidth(context),
        child: historicalWeatherProvider.loading
            ? const Center(child: Loader())
            : historicalWeatherProvider.error
                ? const Center(child: Error())
                : Column(
                    children: [
                      Expanded(
                          child: Scrollbar(
                        interactive: true,
                        radius: Radius.circular(20),
                        thickness: 10,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                historicalWeatherProvider.historicalData.length,
                            itemBuilder: (context, index) {
                              return HistoricalDataCard(
                                appTemperature: historicalWeatherProvider
                                    .historicalData[index].appTemperature
                                    .toDouble(),
                                azimuth: historicalWeatherProvider
                                    .historicalData[index].azimuth
                                    .toDouble(),
                                clouds: historicalWeatherProvider
                                    .historicalData[index].clouds,
                                dewpoint: historicalWeatherProvider
                                    .historicalData[index].dewpoint
                                    .toDouble(),
                                precipitationRate: historicalWeatherProvider
                                    .historicalData[index].precipitationRate
                                    .toDouble(),
                                pressure: historicalWeatherProvider
                                    .historicalData[index].pressure,
                                relativeHumidity: historicalWeatherProvider
                                    .historicalData[index].relativeHumidity,
                                seaLevelPressure: historicalWeatherProvider
                                    .historicalData[index].seaLevelPressure,
                                temperature: historicalWeatherProvider
                                    .historicalData[index].temperature
                                    .toDouble(),
                                localTimestamp: historicalWeatherProvider
                                    .historicalData[index].localTimestamp,
                                uvIndex: historicalWeatherProvider
                                    .historicalData[index].uvIndex
                                    .toDouble(),
                                visibility: historicalWeatherProvider
                                    .historicalData[index].visibility
                                    .toDouble(),
                                weatherCondition: historicalWeatherProvider
                                    .historicalData[index].weatherCondition,
                                icon: historicalWeatherProvider
                                    .historicalData[index].icon,
                                windSpeed: historicalWeatherProvider
                                    .historicalData[index].windSpeed
                                    .toDouble(),
                              );
                            }),
                      ))
                    ],
                  ),
      );
    });
  }
}
