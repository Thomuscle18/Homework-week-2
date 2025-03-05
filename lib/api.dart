import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(AQIMonitorApp());
}

class AQIMonitorApp extends StatelessWidget {
  const AQIMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AirQualityScreen(),
    );
  }
}

class AirQualityScreen extends StatefulWidget {
  const AirQualityScreen({super.key});

  @override
  _AirQualityScreenState createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {
  String city = "Loading...";
  int aqi = 0;
  double temperature = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAirQuality();
    Timer.periodic(Duration(minutes: 5), (timer) {
      fetchAirQuality();
    });
  }

  Future<void> fetchAirQuality() async {
    final url = Uri.parse(
        "https://api.waqi.info/feed/here/?token=4e4114fc3b78b29506437b4989aee605241974ee");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == "ok") {
          setState(() {
            city = data['data']['city']['name'];
            aqi = data['data']['aqi'];
            temperature = data['data']['iaqi']['t']['v'].toDouble();
            isLoading = false;
          });
        } else {
          setState(() {
            city = "Error fetching data";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          city = "Error fetching data";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        city = "Unable to fetch data";
        isLoading = false;
      });
    }
  }

  Color getAqiColor(int aqi) {
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow;
    if (aqi <= 150) return Colors.orange;
    if (aqi <= 200) return Colors.red;
    if (aqi <= 300) return Colors.purple;
    return Colors.brown;
  }

  String getAqiEmoji(int aqi) {
    if (aqi <= 50) return "😊"; // Good
    if (aqi <= 100) return "🙂"; // Moderate
    if (aqi <= 150) return "😐"; // Unhealthy for sensitive groups
    if (aqi <= 200) return "😷"; // Unhealthy
    if (aqi <= 300) return "🤢"; // Very unhealthy
    return "☠️"; // Hazardous
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 245, 232),
      appBar: AppBar(
        title: Text("Air Quality Index (AQI)",
            style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.green[200],
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    city,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            "$aqi ${getAqiEmoji(aqi)}",
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: getAqiColor(aqi),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Temperature: ${temperature.toStringAsFixed(1)}°C",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: fetchAirQuality,
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Refresh"),
                  ),
                ],
              ),
      ),
    );
  }
}
