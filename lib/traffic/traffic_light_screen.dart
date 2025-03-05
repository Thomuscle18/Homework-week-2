import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mytestapp/traffic/traffic_light_widget.dart';

class TrafficLightScreen extends StatefulWidget {
  const TrafficLightScreen({super.key});

  @override
  _TrafficLightScreenState createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  int _lightState = 0;
  int _counter = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _counter = _getDurationForState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _changeLight();
      }
    });
  }

  int _getDurationForState() {
    switch (_lightState) {
      case 0:
        return 10;
      case 1:
        return 3;
      case 2:
        return 10;
      default:
        return 10;
    }
  }

  void _changeLight() {
    setState(() {
      _lightState = (_lightState + 1) % 3;
    });
    _startTimer();
  }

  void _forceChangeLight() {
    _changeLight();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 255, 220),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_counter',
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 20),
            TrafficLightWidget(lightState: _lightState),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _forceChangeLight,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Change'),
            ),
          ],
        ),
      ),
    );
  }
}
