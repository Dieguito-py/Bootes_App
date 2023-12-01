import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bootes_app/widgets/appbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BOOTES Flutter',
      theme: ThemeData(
        fontFamily: 'Lalezar',
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF44454B),
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
  late GoogleMapController mapController;
  late LatLng currentLocation;

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
            altitude = dataList[i].split('.')[0];
          }
        }
      } else if (endpoint == 'gps') {
        latitude = dataList[0];
        longitude = dataList[1];
        updateMap();
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  void updateMap() {
    setState(() {
      currentLocation = LatLng(double.parse(latitude), double.parse(longitude));
    });
  }

  @override
  void initState() {
    super.initState();
    _getData = fetchData('dados'); // Começa obtendo os dados de 'dados'
    _controller = TextEditingController();
    fetchData('gps'); // Obtém os dados de GPS inicialmente
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      setState(() {
        fetchData('dados'); // Atualiza os dados de 'dados' a cada 5 segundos
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
      fetchData('dados'); // Atualiza os dados de 'dados' quando o endereço IP é alterado
      fetchData('gps'); // Obtém os novos dados de GPS ao alterar o endereço IP
      _getData = fetchData('dados'); // Atualiza os dados de 'dados' com o novo endereço IP
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('BOOTES Flutter'),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Appbar(),
            
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
                        if (latitude.isNotEmpty && longitude.isNotEmpty)
                          Container(
                            width: 353,
                            height: 280,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(28)),
                              boxShadow: [BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2, 4),
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                              )]
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20), // Ajuste o valor conforme desejado
                              child: Container(
                                height: 300,
                                child: GoogleMap(
                                  mapType: MapType.satellite,
                                  zoomControlsEnabled: false,
                                  onMapCreated: (GoogleMapController controller) {
                                    mapController = controller;
                                  },
                                  initialCameraPosition: CameraPosition(
                                    target: currentLocation,
                                    zoom: 15.0,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId: MarkerId('currentLocation'),
                                      position: currentLocation,
                                      infoWindow: InfoWindow(
                                        title: 'CubSat',
                                      ),
                                    ),
                                  },
                                ),
                              ),
                            ),
                          ),
                      SizedBox(height: 10),
                        Container(
                              width: MediaQuery.of(context).size.width,
                              height: 310,
                              decoration: const BoxDecoration(
                                // color: Color(0xFF319E3C),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: const AlignmentDirectional(-0.80, -0.85),
                                    child: Container(
                                      width: 198,
                                      height: 138,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1E9A2B),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child:  Stack(
                                        children: [
                                          const Align(
                                            alignment: AlignmentDirectional(-0.65, -0.89),
                                            child: Text('Temperatura',
                                            style: TextStyle(
                                              color: Color(0xFFE7E6D5),
                                              fontSize: 28,
                                            ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(-0.69, 1.4),
                                            child: Text('$temperature°',
                                            style: TextStyle(
                                              fontSize: 80,
                                              color: Color(0xFFE7E6D5)
                                            ),),
                                          ),
                                          Align(
                                            alignment: const AlignmentDirectional(3.4, 0),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  child: Image.asset(
                                                  'assets/images/ternometro.png',
                                                  fit: BoxFit.cover,
                                                  width: 163,
                                                  height:501,
                                                  ),
                                                ),
                                              ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.84, -0.85),
                                    child: Container(
                                      width: 140,
                                      height: 138,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1F8529),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child:  Stack(
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(-0.65, -0.89),
                                            child: Text('Umidade',
                                            style: TextStyle(
                                              color: Color(0xFFE7E6D5),
                                              fontSize: 28,
                                            ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(-0.45, 1),
                                            child: Text('$humidity%',
                                            style: TextStyle(
                                              fontSize: 70,
                                              color: Color(0xFFE7E6D5)
                                            ),),
                                          ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(0.80, 0.94),
                                    child: Container(
                                      width: 198,
                                      height: 138,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1DA42B),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child:  Stack(
                                        children: [
                                          const Align(
                                            alignment: AlignmentDirectional(-0.40, -0.89),
                                            child: Text('Pressão atmosférica',
                                            style: TextStyle(
                                              color: Color(0xFFE7E6D5),
                                              fontSize: 26,
                                            ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(-0.45, 1),
                                            child: Text('$pressure',
                                            style: TextStyle(
                                              fontSize: 70,
                                              color: Color(0xFFE7E6D5)
                                            ),),
                                          ),
                                          Align(
                                            alignment: const AlignmentDirectional(1, 0),
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                  child: Image.asset(
                                                  'assets/images/gauge.png',
                                                  fit: BoxFit.contain,
                                                  width: 113,
                                                  height:401,
                                                  ),
                                                ),
                                              ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(-0.85, 0.94),
                                    child: Container(
                                      width: 140,
                                      height: 138,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1F7A28),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(-0.65, -0.89),
                                            child: Text('Altitude',
                                            style: TextStyle(
                                              color: Color(0xFFE7E6D5),
                                              fontSize: 30,
                                            ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(0, 0.60),
                                            child: Text('$altitude m  ',
                                            style: TextStyle(
                                              fontSize: 60,
                                              color: Color(0xFFE7E6D5)
                                            ),),
                                          ),
                                          // )
                                        ],
                                      ),
                                    ),),
                       
                      ],
                    ))]);
                  }
                },
              ),
              SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE7E6D5),
                    fixedSize: Size(200, 60)
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Insira o Endereço IP!'),
                          content: TextField(
                            controller: _controller,
                            decoration: InputDecoration(hintText: 'Ex: 192.168.1.108'),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                // Atualizando o estado do aplicativo com o novo endereço IP
                                setState(() {
                                  updateBaseUrl('http://${_controller.text}');
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Conectar',
                    style: TextStyle(
                      color: Color(0xFF44454B),
                      fontSize: 20
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
