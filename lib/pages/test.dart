import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOOTES Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    _getData = fetchData('dados'); // Começa obtendo os dados de 'dados'
    _controller = TextEditingController();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      setState(() {
        _getData = fetchData('dados'); // Atualiza os dados de 'dados' a cada 5 segundos
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
      _getData = fetchData('dados'); // Atualiza os dados de 'dados' quando o endereço IP é alterado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BOOTES Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Enter IP Address'),
                      content: TextField(
                        controller: _controller,
                        decoration: InputDecoration(hintText: 'Enter IP Address'),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            updateBaseUrl('http://${_controller.text}');
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Change IP Address'),
            ),
            SizedBox(height: 20),
            FutureBuilder<void>(
              future: _getData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    children: [
                      Text('Humidity: $humidity'),
                      Text('Temperature: $temperature'),
                      Text('Pressure: $pressure'),
                      Text('Altitude: $altitude'),
                      SizedBox(height: 20),
                      Text('Latitude: $latitude'),
                      Text('Longitude: $longitude'),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}