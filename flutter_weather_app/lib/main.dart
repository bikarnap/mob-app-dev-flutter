import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String url =
    'http://api.openweathermap.org/data/2.5/weather?q=tampere&units=metric&appid=35af0216492a302516d1231b29ba0056';
Future<Weather> fetchWeather() async {
  final response =
      //await http.get('https://jsonplaceholder.typicode.com/albums/1');
      await http.get(url);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Weather.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Weather {
  final double temperature;
  final int humidity;
  final int pressure;
  final double feelsLike;
  final String city;

  Weather(
      {this.temperature,
      this.humidity,
      this.pressure,
      this.feelsLike,
      this.city});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      feelsLike: json['main']['feels_like'],
      city: json['name'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Weather> futureWeather;
  bool buttonPressed = false;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    // RaisedButton which on click will update the UI to show weather data
    RaisedButton getWeatherRaisedButton = RaisedButton(
      onPressed: () {
        setState(() {
          buttonPressed = true;
        });
      },
      color: Colors.blue,
      child: Text(
        'Tampere Weather',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
      ),
    );
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tampere Weather'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Text(
                      'Press the button "Tampere Weather" to know the weather' +
                          'information about Tampere city.',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: buttonPressed,
                  child: FutureBuilder<Weather>(
                    future: futureWeather,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Text(
                              "Weather information for " +
                                  snapshot.data.city +
                                  "\n",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Temperature\t" +
                                  snapshot.data.temperature.toString() +
                                  " \u00B0C",
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                              "Feels like\t" +
                                  snapshot.data.feelsLike.toString() +
                                  " \u00B0C\n",
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                              "Humidity\t" +
                                  snapshot.data.humidity.toString() +
                                  " %\n",
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                              "Pressure\t" +
                                  snapshot.data.pressure.toString() +
                                  " Pa\n",
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  ),
                ),
                ButtonTheme(
                  height: 75.0,
                  child: getWeatherRaisedButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
