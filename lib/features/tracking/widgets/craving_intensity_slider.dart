import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

class CravingIntensitySlider extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  
  const CravingIntensitySlider({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Mild'),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _getColorForIntensity(value),
              ),
            ),
            const Text('Severe'),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: _getColorForIntensity(value),
            inactiveTrackColor: Colors.grey[300],
            thumbColor: _getColorForIntensity(value),
            overlayColor: _getColorForIntensity(value).withOpacity(0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
          ),
          child: Slider(
            value: value.toDouble(),
            min: 1,
            max: 10,
            divisions: 9,
            onChanged: (newValue) {
              onChanged(newValue.round());
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            5,
            (index) {
              final intensity = index * 2 + 2; // 2, 4, 6, 8, 10
              return Column(
                children: [
                  Icon(
                    _getIconForIntensity(intensity),
                    color: value >= intensity
                        ? _getColorForIntensity(intensity)
                        : Colors.grey[300],
                    size: 20,
                  ),
                  Text(
                    intensity.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: value >= intensity
                          ? _getColorForIntensity(intensity)
                          : Colors.grey[600],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
  
  Color _getColorForIntensity(int intensity) {
    if (intensity <= 3) {
      return Colors.green;
    } else if (intensity <= 6) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
  
  IconData _getIconForIntensity(int intensity) {
    if (intensity <= 3) {
      return Icons.sentiment_satisfied;
    } else if (intensity <= 6) {
      return Icons.sentiment_neutral;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }
}