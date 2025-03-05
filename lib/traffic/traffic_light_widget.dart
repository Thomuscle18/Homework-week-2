import 'package:flutter/material.dart';

class TrafficLightWidget extends StatelessWidget {
  final int lightState;

  const TrafficLightWidget({super.key, required this.lightState});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildLight(Colors.red, lightState == 0),
          _buildLight(Colors.yellow, lightState == 1),
          _buildLight(Colors.green, lightState == 2),
        ],
      ),
    );
  }

  Widget _buildLight(Color color, bool isActive) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isActive ? 1.0 : 0.3,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
