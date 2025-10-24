import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    //When you add const to column, no need to add const to sized box
    return Column(
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
