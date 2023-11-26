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
  late Future<List<String>> _getData;

  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.1.100/dados'));
    if (response.statusCode == 200) {
      String data = response.body;
      List<String> dataList = data.split("e");
      return dataList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BOOTES Flutter'),
      ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: _getData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<String>? dataList = snapshot.data;
              if (dataList != null && dataList.isNotEmpty) {
                return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Dado ${index + 1}: ${dataList[index]}'),
                    );
                  },
                );
              } else {
                return Text('No data');
              }
            }
          },
        ),
      ),
    );
  }
}
