import 'package:flutter/material.dart';

class DropdownFilter extends StatelessWidget {
  final String title;
  final String selectedValue;
  final Map<String, String> options;
  final ValueChanged<String> onChanged;

  const DropdownFilter({
    super.key,
    required this.title,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        DropdownButton<String>(
          value: selectedValue,
          items: options.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
        ),
      ],
    );
  }
}
