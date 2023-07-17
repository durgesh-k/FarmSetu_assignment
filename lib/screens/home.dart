import 'package:flutter/material.dart';
import 'package:the_weather_app/screens/historical_weather.dart';
import 'package:the_weather_app/screens/weather_forecast.dart';
import 'package:the_weather_app/screens/weather_map.dart';
import 'package:the_weather_app/utils/constants.dart';

import '../utils/converters.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController(initialPage: 1);
  String? title = "Weather Forecast";
  int currentpage = 1;

  Widget generateBottomNavigationButtons() {
    if (currentpage == 0) {
      return Padding(
        padding: const EdgeInsets.all(28.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 1,
            ),
            InkWell(
              onTap: () {
                pageController.animateToPage(1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    'Forecast ▶',
                    style: TextStyle(
                        fontFamily: 'SemiBold', fontSize: 20, color: black),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else if (currentpage == 1) {
      return Padding(
        padding: const EdgeInsets.all(28.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                pageController.animateToPage(0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    '◀ History',
                    style: TextStyle(
                        fontFamily: 'SemiBold', fontSize: 20, color: black),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                pageController.animateToPage(2,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    'Maps ▶',
                    style: TextStyle(
                        fontFamily: 'SemiBold', fontSize: 20, color: black),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(28.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                pageController.animateToPage(1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    '◀ Forecast',
                    style: TextStyle(
                        fontFamily: 'SemiBold', fontSize: 20, color: black),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(getHeight(context) * 0.15),
          child: SafeArea(
            child: SizedBox(
              child: SizedBox(
                height: getHeight(context) * 0.15,
                width: getWidth(context),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title!,
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              color: black,
                              fontSize: 30),
                        ),
                        currentpage == 1
                            ? Text(
                                formatTime(DateTime.now().toString()),
                                style: TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 30,
                                    color: black?.withOpacity(0.15)),
                              )
                            : Container(),
                        currentpage == 2
                            ? Text(
                                "Precipitation and Temperature",
                                style: TextStyle(
                                    fontFamily: 'SemiBold',
                                    color: primary,
                                    fontSize: 18),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (value) {
              if (value == 0) {
                setState(() {
                  title = 'Historical Weather';
                });
              } else if (value == 1) {
                setState(() {
                  title = 'Weather Forecast';
                });
              } else if (value == 2) {
                setState(() {
                  title = 'Weather Map';
                });
              }
              setState(() {
                currentpage = value;
              });
            },
            children: const [
              HistoricalWeather(),
              WeatherForecast(),
              WeatherMap(),
            ],
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: generateBottomNavigationButtons())
        ],
      ),
    );
  }
}
