import 'package:flutter/material.dart';

class ColorSwatchRow extends StatelessWidget {
  final List<Color> colors;

  const ColorSwatchRow({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    if (colors.isEmpty) return const SizedBox.shrink();
    return Row(
      children: colors.map((color) {
        return Expanded(
          child: Container(
            height: 48,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }).toList(),
    );
  }
}
