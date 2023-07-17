import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:the_weather_app/providers/historical_weather_provider.dart';
import 'package:the_weather_app/providers/weather_provider.dart';
import 'package:the_weather_app/screens/home.dart';
import 'package:the_weather_app/utils/constants.dart';
import 'package:the_weather_app/widgets/error.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => HistoricalWeatherProvider()),
        ChangeNotifierProvider(create: (context) => WeatherProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Weather App',
          builder: (context, child) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return ErrorScreen(errorDetails: errorDetails);
            };

            return ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, child!),
                maxWidth: getWidth(context),
                minWidth: 300,
                defaultScale: true,
                mediaQueryData:
                    MediaQuery.of(context).copyWith(textScaleFactor: 0.8),
                breakpoints: [
                  const ResponsiveBreakpoint.resize(300, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
                background: Container(color: const Color(0xFFF5F5F5)));
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Home()),
    );
  }
}
