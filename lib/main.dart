import 'package:bootes_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    late Future<void> _getData;
  late Timer _timer;
  late TextEditingController _controller;
  String baseUrl = 'http://192.168.1.100'; // URL padrão
  late String humidity = '';
  late String temperature = '';
  late String pressure = '';
  late String altitude = '';
  late String latitude = '';
  late String longitude = '';

  Future<void> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      String data = response.body;
      List<String> dataList = data.split("e");

      if (endpoint == 'dados') {
        for (int i = 0; i < dataList.length; i++) {
          if (i == 0) {
            temperature = dataList[i].split('.')[0];
          } else if (i == 1) {
            humidity = dataList[i].split('.')[0];
          } else if (i == 2) {
            pressure = dataList[i];
          } else if (i == 3) {
            altitude = dataList[i];
          }
        }
      } else if (endpoint == 'gps') {
        latitude = dataList[0].split('.')[0];
        longitude = dataList[1].split('.')[0];
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData = fetchData('dados');
    _controller = TextEditingController();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      setState(() {
        _getData = fetchData('dados');
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void updateBaseUrl(String newUrl) {
    setState(() {
      baseUrl = newUrl;
      _getData = fetchData('dados');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bootes App',
      theme: ThemeData(
        fontFamily: 'Lalezar',
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF44454B),
      ),
      home: const HomePage());
  }
}

