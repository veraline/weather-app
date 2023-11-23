import 'package:flutter/material.dart';
import 'package:weather_app/Services/weather_services.dart';
import '';
import '../models/weather-models.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api Key
  final _weatherService = WeatherService('0c988c09b42eac18c74ef313620e7c94');
  Weather? _weather;

  //fetch weather

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    //get the current city

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any errors
    catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'Assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'Assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'Assets/rainy.json';
      case 'thunderstorm':
        return 'Assets/thunder.json';
      case 'clear':
        return 'Assets/sunny.json';
      default:
        return 'Assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(
              _weather?.cityName ?? 'loading City',
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //tempreture
            const SizedBox(
              height: 50,
            ),
            Text(
              '${_weather?.tempreture.round()} \u{2103}',
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),

            Text(_weather?.mainCondition ?? "",
                style: const TextStyle(color: Colors.black, fontSize: 20))
          ],
        ),
      ),
    );
  }
}
