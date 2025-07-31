import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'package:flutter/material.dart';
import '../utils/breathing_accessibility_utils.dart';
import '../../../shared/theme/app_colors.dart';

/// A widget that provides accessibility settings for breathing exercises
class BreathingAccessibilitySettings extends StatefulWidget {
  /// Callback when settings are changed
  final VoidCallback? onSettingsChanged;

  const BreathingAccessibilitySettings({
    Key? key,
    this.onSettingsChanged,
  }) : super(key: key);

  @override
  State<BreathingAccessibilitySettings> createState() => _BreathingAccessibilitySettingsState();
}

class _BreathingAccessibilitySettingsState extends State<BreathingAccessibilitySettings> {
  bool _highContrastEnabled = false;
  bool _hapticFeedbackEnabled = true;
  double _contrastLevel = 1.0;
  int _hapticIntensity = 1;

  @override
  void initState() {
    super.initState();
    // Load current settings
    _highContrastEnabled = BreathingAccessibilityUtils.isHighContrastModeEnabled();
    _hapticFeedbackEnabled = BreathingAccessibilityUtils.isHapticFeedbackEnabled();
    _contrastLevel = BreathingAccessibilityUtils.getContrastLevel();
    _hapticIntensity = BreathingAccessibilityUtils.getHapticIntensity();
  }

  void _updateSettings() {
    BreathingAccessibilityUtils.setHighContrastMode(_highContrastEnabled);
    BreathingAccessibilityUtils.setHapticFeedback(_hapticFeedbackEnabled);
    BreathingAccessibilityUtils.setContrastLevel(_contrastLevel);
    BreathingAccessibilityUtils.setHapticIntensity(_hapticIntensity);
    
    widget.onSettingsChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    final semanticLabel = BreathingAccessibilityUtils.getAccessibilitySettingsSemanticLabel(
      _highContrastEnabled, 
      _hapticFeedbackEnabled
    );
    
    return Semantics(
      label: semanticLabel,
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Accessibility Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // High Contrast Mode
              SwitchListTile(
                title: const Text('High Contrast Mode'),
                subtitle: const Text('Enhances color differences for better visibility'),
                value: _highContrastEnabled,
                onChanged: (value) {
                  setState(() {
                    _highContrastEnabled = value;
                    _updateSettings();
                  });
                },
                secondary: Icon(
                  Icons.contrast,
                  color: _highContrastEnabled ? AppColors.primary : Colors.grey,
                ),
              ),
              
              // Contrast Level Slider (only visible when high contrast is enabled)
              if (_highContrastEnabled)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Contrast Level'),
                      Slider(
                        value: _contrastLevel,
                        min: 1.0,
                        max: 2.0,
                        divisions: 4,
                        label: _contrastLevel.toStringAsFixed(1),
                        onChanged: (value) {
                          setState(() {
                            _contrastLevel = value;
                            _updateSettings();
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Normal'),
                          Text('Maximum'),
                        ],
                      ),
                    ],
                  ),
                ),
              
              const Divider(),
              
              // Haptic Feedback
              SwitchListTile(
                title: const Text('Haptic Feedback'),
                subtitle: const Text('Provides vibration cues during breathing exercises'),
                value: _hapticFeedbackEnabled,
                onChanged: (value) {
                  setState(() {
                    _hapticFeedbackEnabled = value;
                    if (!value) {
                      _hapticIntensity = 0;
                    } else if (_hapticIntensity == 0) {
                      _hapticIntensity = 1;
                    }
                    _updateSettings();
                  });
                },
                secondary: Icon(
                  Icons.vibration,
                  color: _hapticFeedbackEnabled ? AppColors.primary : Colors.grey,
                ),
              ),
              
              // Haptic Intensity (only visible when haptic feedback is enabled)
              if (_hapticFeedbackEnabled)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Haptic Intensity'),
                      Slider(
                        value: _hapticIntensity.toDouble(),
                        min: 1,
                        max: 3,
                        divisions: 2,
                        label: _getHapticIntensityLabel(_hapticIntensity),
                        onChanged: (value) {
                          setState(() {
                            _hapticIntensity = value.round();
                            _updateSettings();
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Light'),
                          Text('Medium'),
                          Text('Strong'),
                        ],
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 16),
              
              // Preview section
              if (_highContrastEnabled)
                _buildContrastPreview(),
            ],
          ),
        ),
      ),
    );
  }

  /// Build a preview of the high contrast colors
  Widget _buildContrastPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'High Contrast Preview:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildColorPreview(
              'Inhale', 
              BreathingAccessibilityUtils.getAccessibleColorForPhase(
                BreathingPhase.inhale, 
                AppColors.primary
              )
            ),
            _buildColorPreview(
              'Hold', 
              BreathingAccessibilityUtils.getAccessibleColorForPhase(
                BreathingPhase.inhaleHold, 
                AppColors.secondary
              )
            ),
            _buildColorPreview(
              'Exhale', 
              BreathingAccessibilityUtils.getAccessibleColorForPhase(
                BreathingPhase.exhale, 
                AppColors.tertiary
              )
            ),
          ],
        ),
      ],
    );
  }

  /// Build a color preview circle with label
  Widget _buildColorPreview(String label, Color color) {
    final textColor = BreathingAccessibilityUtils.getAccessibleTextColor(color);
    
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Get a descriptive label for haptic intensity
  String _getHapticIntensityLabel(int intensity) {
    switch (intensity) {
      case 1:
        return 'Light';
      case 2:
        return 'Medium';
      case 3:
        return 'Strong';
      default:
        return 'Off';
    }
  }
}