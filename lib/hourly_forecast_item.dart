import 'package:flutter/material.dart';

//Saving Card widget in a class
class HourlyForecastItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;

  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.pink,
      //wrap column with padding
      //wrap column with container instead, so you can set border radius with decoration property
      child: Container(
        width: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Icon(icon),
            //Icon(Icons.cloud, size: 32),
            const SizedBox(height: 8),
            Text(temperature),
            //Text("301.11", style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
